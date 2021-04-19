Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA16364770
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbhDSPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240580AbhDSPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618847570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+x2ajsN6vA5q7Sqzhq1ODsacFSkptFt6V8siAoACbA=;
        b=W506B8m2KkcrXYmkY0liSVw/jHs2el2KMJnryyW3wFwtwcBc6KtFMH75X+vk/Jy+Wl0qYj
        c3aCalUbn3BeGT5PWvnl7ITIbt3+XQBm3UJOwxxRTO7BeSU8c6ceDvunhKGtquTaepkoZ4
        DzqN1uGmCCTzWVJBWJyM0qQlqEzHOBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-JaqfVXWSOdaqqfJOlvL-fQ-1; Mon, 19 Apr 2021 11:52:45 -0400
X-MC-Unique: JaqfVXWSOdaqqfJOlvL-fQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5994107ACCA;
        Mon, 19 Apr 2021 15:52:42 +0000 (UTC)
Received: from localhost (ovpn-113-32.ams2.redhat.com [10.36.113.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7B5C5D9C0;
        Mon, 19 Apr 2021 15:52:41 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] capabilities: require CAP_SETFCAP to map uid 0 (v3.2)
In-Reply-To: <m135vne1ez.fsf@fess.ebiederm.org> (Eric W. Biederman's message
        of "Sun, 18 Apr 2021 16:19:16 -0500")
References: <20210416045851.GA13811@mail.hallyn.com>
        <20210416150501.zam55gschpn2w56i@wittgenstein>
        <20210416213453.GA29094@mail.hallyn.com>
        <20210417021945.GA687@mail.hallyn.com>
        <20210417200434.GA17430@mail.hallyn.com>
        <m135vne1ez.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Mon, 19 Apr 2021 17:52:39 +0200
Message-ID: <87mttu9sqg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Guiseppe can you take a look at this?
>
> This is a second attempt at tightening up the semantics of writing to
> file capabilities from a user namespace.
>
> The first attempt was reverted with 3b0c2d3eaa83 ("Revert 95ebabde382c
> ("capabilities: Don't allow writing ambiguous v3 file capabilities")"),
> which corrected the issue reported in:
> https://github.com/containers/buildah/issues/3071
>
> There is a report the podman testsuite passes.  While different this
> looks in many ways much more strict than the code that was reverted.  So
> while I can imagine this change doesn't cause problems as is, I will be
> surprised.

thanks for pulling me in the discussion.

I've tested the patch with several cases similar to the issue we had in
the past and the patch seems to work well.  

Podman creates all the user namespaces within the same parent user
namespace.  In the parent user namespace all the capabilities are kept
and AFAIK Docker does the same.  I'd expect a change in behavior only
for nested user namespaces in containers where CAP_SETFCAP is not
granted, but that is not a common configuration given that CAP_SETFCAP
is added by default.


> "Serge E. Hallyn" <serge@hallyn.com> writes:
>
>> +/**
>> + * verify_root_map() - check the uid 0 mapping
>> + * @file: idmapping file
>> + * @map_ns: user namespace of the target process
>> + * @new_map: requested idmap
>> + *
>> + * If a process requested a mapping for uid 0 onto uid 0, verify that the
>> + * process writing the map had the CAP_SETFCAP capability as the target process
>> + * will be able to write fscaps that are valid in ancestor user namespaces.
>> + *
>> + * Return: true if the mapping is allowed, false if not.
>> + */
>> +static bool verify_root_map(const struct file *file,
>> +			    struct user_namespace *map_ns,
>> +			    struct uid_gid_map *new_map)
>> +{
>> +	int idx;
>> +	const struct user_namespace *file_ns = file->f_cred->user_ns;
>> +	struct uid_gid_extent *extent0 = NULL;
>> +
>> +	for (idx = 0; idx < new_map->nr_extents; idx++) {
>> +		u32 lower_first;

nit: lower_first seems unused?

>> +
>> +		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
>> +			extent0 = &new_map->extent[idx];
>> +		else
>> +			extent0 = &new_map->forward[idx];
>> +		if (extent0->lower_first == 0)
>> +			break;
>> +
>> +		extent0 = NULL;
>> +	}

Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>

Regards,
Giuseppe

