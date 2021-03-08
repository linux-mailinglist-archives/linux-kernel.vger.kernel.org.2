Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04F3314B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCHRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:23:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:42056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhCHRXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615224227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+EIEER3IS7YP0m4/fPGj2vxiIdkWH09Qd5bp/wtqH8=;
        b=Gpsc7Kt/3A46Fl310GAfDnt5PxoiHsIqagYQidROqtJlpGubeGYAJCub2L1+YPOpUYM1C4
        54hnM+qr3Cv6azCTBlwUSmTue+cUHZTPn2ZebAEeA/kqWdICZsFoOAB9M4fu0zS8Karvkm
        mACixHyKMbM8QrlAN9oziMwnCt02veI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6A48AC0C;
        Mon,  8 Mar 2021 17:23:47 +0000 (UTC)
Date:   Mon, 8 Mar 2021 18:23:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers
 warning
Message-ID: <YEZdo0L8otuEJZNW@alley>
References: <20210305194206.3165917-1-elver@google.com>
 <20210305194206.3165917-2-elver@google.com>
 <YEX5fyB16dF6N4Iu@alley>
 <CAMuHMdUDqcWfE67g2ah-JyL3H9-G_5nrtQLyq0A3OXTKPFXv6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUDqcWfE67g2ah-JyL3H9-G_5nrtQLyq0A3OXTKPFXv6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-08 13:22:40, Geert Uytterhoeven wrote:
> Hi Petr,
> 
> On Mon, Mar 8, 2021 at 11:16 AM Petr Mladek <pmladek@suse.com> wrote:
> > On Fri 2021-03-05 20:42:06, Marco Elver wrote:
> > > Move the no_hash_pointers warning string into __initconst section, so
> > > that it is discarded after init. Remove common start/end characters.
> > > Also remove repeated lines from the array, since the compiler can't
> > > remove duplicate strings for us since the array must appear in
> > > __initconst as defined.
> > >
> > > Note, a similar message appears in kernel/trace/trace.c, but compiling
> > > the feature is guarded by CONFIG_TRACING. It is not immediately obvious
> > > if a space-concious kernel would prefer CONFIG_TRACING=n. Therefore, it
> > > makes sense to keep the message for no_hash_pointers as __initconst, and
> > > not move the NOTICE-printing to a common function.
> > >
> > > Link: https://lkml.kernel.org/r/CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  lib/vsprintf.c | 30 +++++++++++++++++-------------
> > >  1 file changed, 17 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > index 4a14889ccb35..1095689c9c97 100644
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -2094,26 +2094,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> > >  bool no_hash_pointers __ro_after_init;
> > >  EXPORT_SYMBOL_GPL(no_hash_pointers);
> > >
> > > +static const char no_hash_pointers_warning[8][55] __initconst = {
> > > +     "******************************************************",
> > > +     "   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> > > +     " This system shows unhashed kernel memory addresses   ",
> > > +     " via the console, logs, and other interfaces. This    ",
> > > +     " might reduce the security of your system.            ",
> > > +     " If you see this message and you are not debugging    ",
> > > +     " the kernel, report this immediately to your system   ",
> > > +     " administrator!                                       ",
> > > +};
> > > +
> > >  static int __init no_hash_pointers_enable(char *str)
> > >  {
> > > +     /* Indices into no_hash_pointers_warning; -1 is an empty line. */
> > > +     const int lines[] = { 0, 1, -1, 2, 3, 4, -1, 5, 6, 7, -1, 1, 0 };
> > > +     int i;
> > > +
> > >       if (no_hash_pointers)
> > >               return 0;
> > >
> > >       no_hash_pointers = true;
> > >
> > > -     pr_warn("**********************************************************\n");
> > > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > -     pr_warn("**                                                      **\n");
> > > -     pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > > -     pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > > -     pr_warn("** might reduce the security of your system.            **\n");
> > > -     pr_warn("**                                                      **\n");
> > > -     pr_warn("** If you see this message and you are not debugging    **\n");
> > > -     pr_warn("** the kernel, report this immediately to your system   **\n");
> > > -     pr_warn("** administrator!                                       **\n");
> > > -     pr_warn("**                                                      **\n");
> > > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > -     pr_warn("**********************************************************\n");
> > > +     for (i = 0; i < ARRAY_SIZE(lines); i++)
> > > +             pr_warn("**%54s**\n", i == -1 ? "" : no_hash_pointers_warning[lines[i]]);
> >
> > Is this worth it, please? Could anyone provide some numbers how
> 
> Yeah, the code indeed starts to look a bit cumbersome...
> 
> > the kernel size increases between releases?
> 
> I'd say 20 KiB per release, on average.
> 
> > The number of code lines is basically just growing. The same is true
> > for the amount of printed messages.
> 
> Yeah, we keep on adding more messages.
> But do we really need to print a message of 13 lines?
> If you consider this critical for security, perhaps it should use pr_crit(),
> or pr_alert()? But please don't print more than a single line.
> 
> <sarcastic>
> Perhaps it should print a URL to a message instead, like the
> "software license" option in Android systems and apps?
> </sarcastic>
> 
> > This patch is saving some lines of text that might be effectively
> > compressed. But it adds some code and array with indexes. Does it
> > make any significant imrovement in the compressed kernel image?
> >
> > Geert was primary concerned about the runtime memory consuption.
> > It will be solved by the  __initconst. The rest affects only
> > the size of the compressed image on disk.
> 
> I'm actually concerned about both.  Platforms (and boot loaders) may
> have limitations for kernel image size, too.
> Static memory consumption is also more easily measured, so I tend
> to run bloat-o-meter, and dive into anything that adds more than 1 KiB.
> And yes, this message is a low-hanging fruit...

OK, I wondered how big trick does the  __initconst on its own.

1. I compiled kernel without this patchset:

$# ll /boot/vmlinux-5.12.0-rc2-default+.bz2
-rwxr-xr-x 1 root root 18911364 Mar  8 15:58 /boot/vmlinux-5.12.0-rc2-default+.bz2

2. With this patchset:

$# ll /boot/vmlinux-5.12.0-rc2-default+.bz2
-rwxr-xr-x 1 root root 18910767 Mar  8 16:16 /boot/vmlinux-5.12.0-rc2-default+.bz2
$# echo $((18910767 - 18911364))
-597

3. With the patch below:

$# ll /boot/vmlinux-5.12.0-rc2-default+.bz2
-rwxr-xr-x 1 root root 18910906 Mar  8 16:58 /boot/vmlinux-5.12.0-rc2-default+.bz2
$# echo $((18910906 - 18911364))
-458

This patchset saves 139B more than a simple array.


Well, I am a bit confused. I have tried to keep the strings as a
static variable outside the function:

static const char *no_hash_pointers_warning[] __initconst = {
	...

and I got the following build error:

  CC      lib/vsprintf.o
lib/vsprintf.c:2097:20: error: no_hash_pointers_warning causes a section type conflict with __setup_str_no_hash_pointers_enable
 static const char *no_hash_pointers_warning[] __initconst = {
                    ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/printk.h:6:0,
                 from ./include/linux/kernel.h:16,
                 from ./include/linux/clk.h:13,
                 from lib/vsprintf.c:22:
./include/linux/init.h:315:20: note: ‘__setup_str_no_hash_pointers_enable’ was declared here
  static const char __setup_str_##unique_id[] __initconst  \
                    ^
./include/linux/init.h:330:2: note: in expansion of macro ‘__setup_param’
  __setup_param(str, fn, fn, 1)
  ^~~~~~~~~~~~~
lib/vsprintf.c:2127:1: note: in expansion of macro ‘early_param’
 early_param("no_hash_pointers", no_hash_pointers_enable);
 ^~~~~~~~~~~


I solved this be defining the array inside the function that is marked
__init. But I am not sure if it is the correct solution. And I wonder
why the original patch did not have this problem.

Also I am curious why the array reduced the size of the binary so
significantly in compare with the const strings used as pr_warn()
arguments. It might depend on the compression method or???


Anyway, here is the patch that works for me and reduced the size of
the binary considerably:

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 4a14889ccb35..af01edae0d86 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2096,24 +2096,30 @@ EXPORT_SYMBOL_GPL(no_hash_pointers);
 
 static int __init no_hash_pointers_enable(char *str)
 {
+	int i;
+	const char *no_hash_pointers_warning[] = {
+		"**********************************************************",
+		"**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **",
+		"**                                                      **",
+		"** This system shows unhashed kernel memory addresses   **",
+		"** via the console, logs, and other interfaces. This    **",
+		"** might reduce the security of your system.            **",
+		"**                                                      **",
+		"** If you see this message and you are not debugging    **",
+		"** the kernel, report this immediately to your system   **",
+		"** administrator!                                       **",
+		"**                                                      **",
+		"**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **",
+		"**********************************************************",
+	};
+
 	if (no_hash_pointers)
 		return 0;
 
 	no_hash_pointers = true;
 
-	pr_warn("**********************************************************\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
-	pr_warn("** via the console, logs, and other interfaces. This    **\n");
-	pr_warn("** might reduce the security of your system.            **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** If you see this message and you are not debugging    **\n");
-	pr_warn("** the kernel, report this immediately to your system   **\n");
-	pr_warn("** administrator!                                       **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**********************************************************\n");
+	for (i = 0; i < ARRAY_SIZE(no_hash_pointers_warning); i++)
+		pr_warn("%s\n", no_hash_pointers_warning[i]);
 
 	return 0;
 }


Honestly, I do not want to spend much more time on this. I made the
test out of curiosity.

Feel free to provide the patch using the array, ideally with some
numbers how it helps. But please _avoid_ the indirection via

    const int lines[] = { 0, 1, -1, 2, 3, 4, -1, 5, 6, 7, -1, 1, 0 };

and also _avoid_ all the hardcoded constants, like:

      no_hash_pointers_warning[8][55]

and

      pr_warn("**%54s**\n"

They are error prone and hard to maintain. Such tricks are not
worth it from my POV.

Best Regards,
Petr
