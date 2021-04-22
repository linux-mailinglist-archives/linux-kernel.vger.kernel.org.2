Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA3A36815C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhDVNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:21:26 -0400
Received: from mail.hallyn.com ([178.63.66.53]:39666 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235830AbhDVNVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:21:24 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 47600BEE; Thu, 22 Apr 2021 08:20:48 -0500 (CDT)
Date:   Thu, 22 Apr 2021 08:20:48 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3.4] capabilities: require CAP_SETFCAP to map uid 0
Message-ID: <20210422132048.GA25068@mail.hallyn.com>
References: <20210416150501.zam55gschpn2w56i@wittgenstein>
 <20210416213453.GA29094@mail.hallyn.com>
 <20210417021945.GA687@mail.hallyn.com>
 <20210417200434.GA17430@mail.hallyn.com>
 <20210419122514.GA20598@mail.hallyn.com>
 <20210419160911.5pguvpj7kfuj6rnr@wittgenstein>
 <20210420034208.GA2830@mail.hallyn.com>
 <20210420083129.exyn7ptahx2fg72e@wittgenstein>
 <20210420134334.GA11582@mail.hallyn.com>
 <m15z0fphwt.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15z0fphwt.fsf@fess.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:16:34PM -0500, Eric W. Biederman wrote:
> "Serge E. Hallyn" <serge@hallyn.com> writes:
> 
> > +/**
> > + * verify_root_map() - check the uid 0 mapping
> > + * @file: idmapping file
> > + * @map_ns: user namespace of the target process
> > + * @new_map: requested idmap
> > + *
> > + * If a process requests mapping parent uid 0 into the new ns, verify that the
> > + * process writing the map had the CAP_SETFCAP capability as the target process
> > + * will be able to write fscaps that are valid in ancestor user namespaces.
> > + *
> > + * Return: true if the mapping is allowed, false if not.
> > + */
> > +static bool verify_root_map(const struct file *file,
> > +			    struct user_namespace *map_ns,
> > +			    struct uid_gid_map *new_map)
> > +{
> > +	int idx;
> > +	const struct user_namespace *file_ns = file->f_cred->user_ns;
> > +	struct uid_gid_extent *extent0 = NULL;
> > +
> > +	for (idx = 0; idx < new_map->nr_extents; idx++) {
> > +		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> > +			extent0 = &new_map->extent[idx];
> > +		else
> > +			extent0 = &new_map->forward[idx];
> > +		if (extent0->lower_first == 0)
> > +			break;
> > +
> > +		extent0 = NULL;
> > +	}
> > +
> > +	if (!extent0)
> > +		return true;
> > +
> > +	if (map_ns == file_ns) {
> > +		/* The process unshared its ns and is writing to its own
> > +		 * /proc/self/uid_map.  User already has full capabilites in
> > +		 * the new namespace.  Verify that the parent had CAP_SETFCAP
> > +		 * when it unshared.
> > +		 * */
> > +		if (!file_ns->parent_could_setfcap)
> > +			return false;
> > +	} else {
> > +		/* Process p1 is writing to uid_map of p2, who is in a child
> > +		 * user namespace to p1's.  Verify that the opener of the map
> > +		 * file has CAP_SETFCAP against the parent of the new map
> > +		 * namespace */
> > +		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
> > +			return false;
> > +	}
> 
> Is there any reason this permission check is not simply:
> 
> 	return map_ns->parent_could_setfcap ||
>                file_ns_capable(file, map_ns->parent, CAP_SETFCAP);
>
> That is why don't we allow any mapping (that is otherwise valid) in user
> namespaces whose creator had the permission to call CAP_SETFCAP?

Well I guess the question is exactly who has to have the privilege.

If task X does the unshare and its sibling task Y writes the mapping
(technically, opens the map file), do we want to say that it suffices
for *either* X or Y to have CAP_SETFCAP?  I was thinking we want to
require task Y to have the privilege.  Task X having it would not
suffice.

> Why limit the case of using the creators permissions to only the case of
> mapping just a single uid (that happens to be the current euid) in the
> user namespace?
> 
> I don't see any safety reasons for the map_ns == file_ns test.
> 
> 
> 
> Is the file_ns_capable check for CAP_SETFCAP actually needed?  AKA could
> the permission check be simplified to:
> 
> 	return map_ns->parent_could_setfcap;

Currently uid 1000 can create a new user namespace, then have a fully privileged
root process in uid 1000's peer userns write a 0 mapping.  With just this
check, that would not be possible.

> That would be a much easier rule to explain to people.
> 
> I seem to remember distributions at least trying to make newuidmap have
> just CAP_SETUID and newgidmap have just CAP_SETGID.  Such a simplified
> check would facilitate that.

Yes they would have to add an additional CAP_SETFCAP.
