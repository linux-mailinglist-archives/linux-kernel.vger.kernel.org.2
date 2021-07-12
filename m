Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A63C656A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhGLV11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:27:27 -0400
Received: from mx.ungleich.ch ([185.203.112.16]:44392 "EHLO smtp.ungleich.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhGLV10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:27:26 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jul 2021 17:27:26 EDT
Received: from nb3.localdomain (localhost [IPv6:::1])
        by smtp.ungleich.ch (Postfix) with ESMTP id D72791FE49;
        Mon, 12 Jul 2021 23:16:47 +0200 (CEST)
Received: by nb3.localdomain (Postfix, from userid 1000)
        id A9A4814CC252; Mon, 12 Jul 2021 23:17:35 +0200 (CEST)
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyGrUvA4LjydcP3@kroah.com>
 <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyVH3qD9O3qsNUL@kroah.com>
 <alpine.LRH.2.02.2107121528270.11724@file01.intranet.prod.int.rdu2.redhat.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts/setlocalversion: fix a bug when LOCALVERSION
 is empty
In-reply-to: <alpine.LRH.2.02.2107121528270.11724@file01.intranet.prod.int.rdu2.redhat.com>
Date:   Mon, 12 Jul 2021 23:17:35 +0200
Message-ID: <87tukzgrkg.fsf@ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry to say, but I am not convinced by the patch.

While yes, we might have changed the behaviour slightly, reading
something on the line of

if [ -z ... ]

is significantly more simple, elegant and easier to maintain, than
a rather atypical special case for setting a variable to empty,
using

if [ "${LOCALVERSION+set}" != "set" ] ..

*and* because it is so atypical, adding a long comment for it, too.

Additonally, -z should be correct if the variable *is* truly empty. I
assume it actually isn't and contains whitespace, which is not the same
as being set and empty.

Instead of re-adding complexity, could you consider changing the build
flow so that LOCALVERSION is either unset or empty?

Nico

Executed in bash:

% touch empty
% a=$(cat empty)
% [ -z "$a" ]  && echo "really empty"
really empty


Mikulas Patocka <mpatocka@redhat.com> writes:

> On Mon, 12 Jul 2021, Greg Kroah-Hartman wrote:
>
>> On Mon, Jul 12, 2021 at 03:06:48PM -0400, Mikulas Patocka wrote:
>> >
>> >
>> > On Mon, 12 Jul 2021, Greg Kroah-Hartman wrote:
>> >
>> > > On Mon, Jul 12, 2021 at 10:00:59AM -0400, Mikulas Patocka wrote:
>> > > > The patch 042da426f8ebde012be9429ff705232af7ad7469
>> > > > ("scripts/setlocalversion: simplify the short version part") reduces the
>> > > > indentation. Unfortunatelly, it also changes behavior in a subtle way - if
>> > > > the user has empty "LOCALVERSION" variable, the plus sign is appended to
>> > > > the kernel version. It wasn't appended before.
>> > > >
>> > > > This patch reverts to the old behavior - we append the plus sign only if
>> > > > the LOCALVERSION variable is not set.
>> > > >
>> > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>> > > > Fixes: 042da426f8eb ("scripts/setlocalversion: simplify the short version part")
>> > > >
>> > > > ---
>> > > >  scripts/setlocalversion |    2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > >
>> > > > Index: linux-2.6/scripts/setlocalversion
>> > > > ===================================================================
>> > > > --- linux-2.6.orig/scripts/setlocalversion	2021-07-12 15:29:07.000000000 +0200
>> > > > +++ linux-2.6/scripts/setlocalversion	2021-07-12 15:50:29.000000000 +0200
>> > > > @@ -131,7 +131,7 @@ res="${res}${CONFIG_LOCALVERSION}${LOCAL
>> > > >  if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
>> > > >  	# full scm version string
>> > > >  	res="$res$(scm_version)"
>> > > > -elif [ -z "${LOCALVERSION}" ]; then
>> > > > +elif [ "${LOCALVERSION+set}" != "set" ]; then
>> > >
>> > > That's really subtle, can you add a comment here that this handles an
>> > > empty file?
>> > >
>> > > thanks,
>> > >
>> > > greg k-h
>> >
>> > OK.
>> >
>> >
>> > From: Mikulas Patocka <mpatocka@redhat.com>
>> >
>>
>> I can't take a patch like this :(
>>
>> > The patch 042da426f8ebde012be9429ff705232af7ad7469
>> > ("scripts/setlocalversion: simplify the short version part") reduces
>>
>> Properly quote commits, the documentation says you do not need to use
>> the full sha1.
>
>
>
> From: Mikulas Patocka <mpatocka@redhat.com>
>
> The commit 042da426f8eb ("scripts/setlocalversion: simplify the short
> version part") reduces indentation. Unfortunately, it also changes behavior
> in a subtle way - if the user has empty "LOCALVERSION" variable, the plus
> sign is appended to the kernel version. It wasn't appended before.
>
> This patch reverts to the old behavior - we append the plus sign only if
> the LOCALVERSION variable is not set.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 042da426f8eb ("scripts/setlocalversion: simplify the short version part")
>
> ---
>  scripts/setlocalversion |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> Index: linux-2.6/scripts/setlocalversion
> ===================================================================
> --- linux-2.6.orig/scripts/setlocalversion	2021-07-12 15:29:07.000000000 +0200
> +++ linux-2.6/scripts/setlocalversion	2021-07-12 21:00:59.000000000 +0200
> @@ -131,11 +131,14 @@ res="${res}${CONFIG_LOCALVERSION}${LOCAL
>  if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
>  	# full scm version string
>  	res="$res$(scm_version)"
> -elif [ -z "${LOCALVERSION}" ]; then
> -	# append a plus sign if the repository is not in a clean
> -	# annotated or signed tagged state (as git describe only
> -	# looks at signed or annotated tags - git tag -a/-s) and
> -	# LOCALVERSION= is not specified
> +elif [ "${LOCALVERSION+set}" != "set" ]; then
> +	# If the variable LOCALVERSION is not set, append a plus
> +	# sign if the repository is not in a clean annotated or
> +	# signed tagged state (as git describe only looks at signed
> +	# or annotated tags - git tag -a/-s).
> +	#
> +	# If the variable LOCALVERSION is set (including being set
> +	# to an empty string), we don't want to append a plus sign.
>  	scm=$(scm_version --short)
>  	res="$res${scm:++}"
>  fi


--
Sustainable and modern Infrastructures by ungleich.ch
