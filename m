Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16198449D46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 21:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhKHU4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 15:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233001AbhKHU4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:56:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37E1619E2;
        Mon,  8 Nov 2021 20:54:00 +0000 (UTC)
Date:   Mon, 8 Nov 2021 15:53:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211108155359.63606e95@gandalf.local.home>
In-Reply-To: <20211108195642.GA1727@kbox>
References: <20211104170433.2206-1-beaub@linux.microsoft.com>
        <20211104170433.2206-3-beaub@linux.microsoft.com>
        <20211107131850.19021b4e@rorschach.local.home>
        <20211108195642.GA1727@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 11:56:42 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Sun, Nov 07, 2021 at 01:18:50PM -0500, Steven Rostedt wrote:
> > On Thu,  4 Nov 2021 10:04:25 -0700
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:  
> > > +static int user_field_array_size(const char *type)
> > > +{
> > > +	const char *start = strchr(type, '[');
> > > +	int size = 0;
> > > +
> > > +	if (start == NULL)
> > > +		return -EINVAL;
> > > +
> > > +	start++;
> > > +
> > > +	while (*start >= '0' && *start <= '9')  
> > 
> > The kernel has include/linux/ctype.h
> > 
> > 	while (isdigit(*start))
> >   
> > > +		size = (size * 10) + (*start++ - '0');  
> > 
> > So you only allow decimal digits? No hex?
> >   
> 
> Happy to change it, I only expected decimal to be allowed.

I'm more worried that if the output of the "registered events" may have a
hex number, and someone uses that output to recreate the event.

> 
> Is there a strong need for hex? (IE: kstrtouint(start, 0, ...)?
> 
> > Also, is there anything to check if the size overflows?
> > 
> > I'm assuming that other patches will add checking if the size is
> > greater than some amount?
> >   
> 
> I can switch to kstrtouint and use a max check, however:
> The max checks are weird here because eBPF has no limits, while ftrace 
> and perf both do (and I believe they are different max sizes?)

I'm not concerned about taking up more than ftrace or perf, but having some
kind of DOS that is caused by hugh allocations. If you make a huge event
and try to record it in ftrace, then ftrace will simply drop the event. No
harm done (except you won't see the event).

> 
> If someone really wanted a large array of characters and it can fit
> within perf but not ftrace, is it correct to block it here? My thinking
> was to allow each trace buffer reserve call to either work or not based
> on what the user requested depending on what was hooked.
> 
> No strong opinion here though, just thoughts about what is a reasonable
> max given the 3 technologies.

Again, I'm more worried about just a general 'this is way too big' thing.
If anything, it could be simply to flag a bug where the event in created
via some logic that goes crazy.

> 
> > > +/*
> > > + * Parses the values of a field within the description
> > > + * Format: type name [size]
> > > + */
> > > +static int user_event_parse_field(char *field, struct user_event *user,
> > > +				  u32 *offset)
> > > +{
> > > +	char *part, *type, *name;
> > > +	u32 depth = 0, saved_offset = *offset;
> > > +	int size = -EINVAL;
> > > +	bool is_struct = false;
> > > +
> > > +	field = skip_spaces(field);
> > > +
> > > +	if (*field == 0)
> > > +		return 0;
> > > +
> > > +	/* Handle types that have a space within */
> > > +	if (strstr(field, "unsigned ") == field) {  
> > 
> > These should use str_has_prefix(field, "unsigned ") etc.
> > 
> > It also returns the length of the prefix so you don't need to add
> > sizeof() of the string you checked for.
> >   
> 
> Nice, will use that.
> 
> > > +
> > > +static struct trace_event_fields user_event_fields_array[] = {
> > > +	{}
> > > +};  
> > 
> > Isn't the above just a fancy way of writing:
> > 
> > static struct trace_event_fields user_event_fields_array[1];
> > 
> > ?
> >   
> 
> Yes, as long as it gets init'd to zero. My understanding was that {}
> would force zeroing, but I could totally be wrong.

All static and global variables that are not assigned will be initialized
to zero. No need to initialize anything that is zero by default.

> 
> > > +/*
> > > + * Writes the user supplied payload out to a trace file.
> > > + */
> > > +static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
> > > +			      void *tpdata)
> > > +{
> > > +	struct trace_event_file *file;
> > > +	struct trace_entry *entry;
> > > +	struct trace_event_buffer event_buffer;
> > > +
> > > +	file = (struct trace_event_file *)tpdata;
> > > +
> > > +	if (!file ||
> > > +	    !(file->flags & EVENT_FILE_FL_ENABLED) ||
> > > +	    trace_trigger_soft_disabled(file))
> > > +		return;
> > > +
> > > +	entry = trace_event_buffer_reserve(&event_buffer, file,
> > > +					   sizeof(*entry) + datalen);
> > > +
> > > +	if (unlikely(!entry))
> > > +		return;
> > > +  
> > 
> > Might want to add a comment here that the trace_event_buffer_reserve()
> > will fill in the struct trace_entry, which explains the "entry+1" below.
> > 
> > I also need to add comments to trace_event_buffer_reserve() that it does so :-p
> >   
> 
> Will do.
> 
> > > +/*
> > > + * Update the register page that is shared between user processes.
> > > + */
> > > +static void update_reg_page_for(struct user_event *user)
> > > +{
> > > +	struct tracepoint *tp = &user->tracepoint;
> > > +	char status = 0;
> > > +
> > > +	if (atomic_read(&tp->key.enabled) > 0) {
> > > +		struct tracepoint_func *probe_func_ptr;
> > > +		user_event_func_t probe_func;
> > > +
> > > +		rcu_read_lock_sched();
> > > +
> > > +		probe_func_ptr = rcu_dereference_sched(tp->funcs);
> > > +
> > > +		if (probe_func_ptr) {
> > > +			do {
> > > +				probe_func = probe_func_ptr->func;
> > > +
> > > +				if (probe_func == user_event_ftrace)
> > > +					status |= EVENT_STATUS_FTRACE;
> > > +				else
> > > +					status |= EVENT_STATUS_OTHER;
> > > +			} while ((++probe_func_ptr)->func);
> > > +		}
> > > +
> > > +		rcu_read_unlock_sched();
> > > +	}
> > > +
> > > +	register_page_data[user->index] = status;  
> > 
> > Should there be some kind of memory barriers here? That is, isn't this
> > the page that user space sees? The user space code should probably have
> > some kind of read memory barrier as well.
> >   
> 
> I'm glad you brought this up. I wanted to ensure a balance between
> eventual enablement of the event in the user mode process vs the cost
> of simultaneous enablement of the event (stalls, etc).
> 
> We haven't seen this become an issue for our teams in our other
> telemetry sources (with no barriers), which seems to indicate eventual
> agreement of the page data works well as a tradeoff.

Another approach is if you know what tasks these events come from (who
registered them), then you could simply send an IPI to the task if it
happen to be running. An IPI will force a memory barrier, and since you
only need to do this on changes (enable / disable event) it's not like it
will happen often.

> 
> > > +static int user_event_create(const char *raw_command)
> > > +{
> > > +	struct user_event *user;
> > > +	char *name;
> > > +	int ret;
> > > +
> > > +	if (strstr(raw_command, USER_EVENTS_PREFIX) != raw_command)
> > > +		return -ECANCELED;
> > > +
> > > +	raw_command += USER_EVENTS_PREFIX_LEN;
> > > +	raw_command = skip_spaces(raw_command);
> > > +
> > > +	name = kstrdup(raw_command, GFP_KERNEL);  
> > 
> > name is allocated here, it really needs to be freed in this function as
> > well. I see that user_event_parse() will free it, but that is extremely
> > error prone to have a dependency like that. If name needs to be saved
> > by user_event_parse_cmd() then that should be shown in the return value
> > of that function. And if it fails the freeing of name should be in this
> > function. Also, if it is saved, then there should be a comment in this
> > function stating that.
> >   
> 
> It's a bit tricky, because if the event already exists, the name is
> freed. If the function fails, the name is freed. If the event has
> never been seen before then it is saved.

I would then suggest to free the name from the calling function only if it
succeeds and the name already exists. With a comment stating that.

But I would have the caller free it on failure. That is, you could change
user_event_parse() to have:

	struct user_event *user = find_user_event(name, &key);

	if (user) {
		*newuser = user;
		/*
		 * The name is allocated by the caller, but since it
		 * already exists in user, simply free it here.
		 */
		kfree(name);
		return 0;
	}

And remove all the "put_name" jumps.

> 
> I'll try to make this more clear, my thought is to add an explicit
> argument that gets set back to the caller if the string should be freed
> or not to make this clear while reading the code.
> 
> > > +static bool user_event_is_busy(struct dyn_event *ev)
> > > +{
> > > +	struct user_event *user = container_of(ev, struct user_event, devent);
> > > +
> > > +	return atomic_read(&user->refcnt) != 0;
> > > +}
> > > +
> > > +static int user_event_free(struct dyn_event *ev)
> > > +{
> > > +	struct user_event *user = container_of(ev, struct user_event, devent);
> > > +  
> > 
> > Shouldn't this check if the event is busy first?  
> 
> Yes, you are right. In the release all case busy is checked by
> dyn_events for me. However, in the individual case it is not. I'll fix
> this.
> 
> > > +/*
> > > + * Validates the user payload and writes via iterator.
> > > + */
> > > +static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> > > +{
> > > +	struct user_event_refs *refs;
> > > +	struct user_event *user = NULL;
> > > +	struct tracepoint *tp;
> > > +	ssize_t ret = i->count;
> > > +	int idx;
> > > +
> > > +	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
> > > +		return -EFAULT;
> > > +
> > > +	rcu_read_lock_sched();
> > > +
> > > +	refs = rcu_dereference_sched(file->private_data);
> > > +
> > > +	if (likely(refs && idx < refs->count))
> > > +		user = refs->events[idx];
> > > +
> > > +	rcu_read_unlock_sched();
> > > +
> > > +	if (unlikely(user == NULL))
> > > +		return -ENOENT;
> > > +
> > > +	tp = &user->tracepoint;  
> > 
> > What protects user here? You released the rcu lock.  
> 
> user is ref counted by the file, so before the final close all events
> linked to the file via the reg ioctl are ref'd and cannot go away.


If that's the case, then why the rcu_read_lock_sched() around the assigment
of user?

-- Steve


> 
> >   
> > > +
> > > +	if (likely(atomic_read(&tp->key.enabled) > 0)) {
> > > +		struct tracepoint_func *probe_func_ptr;
> > > +		user_event_func_t probe_func;
> > > +		void *tpdata;
> > > +		void *kdata;
> > > +		u32 datalen;
> > > +
> > > +		kdata = kmalloc(i->count, GFP_KERNEL);  
> 
