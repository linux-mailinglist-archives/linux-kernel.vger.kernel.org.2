Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED875364A77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhDSTXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbhDSTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:23:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61454C06174A;
        Mon, 19 Apr 2021 12:22:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 448F19B1;
        Mon, 19 Apr 2021 19:22:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 448F19B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618860152; bh=yaDA6z7FVDEXYdGxGBTspjFNCzFzqHlqCi96e7FE6vE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BAyfQt58cduIYo8UmnsWtFq9fjlKSTrLj5iGya+fWB3aTmYzUXBXaQ9kdHU80gwGO
         /zQWX2SU+0LOCesJ+w3/Ts4gPb0dTIofc0njZT1cs7JQLLiSoOXRdnG2edndbEuIje
         czqVuyy98X0sx+vSkMxJ2dNsmf/AHDeXK/ezTV0sr18RUWqs/8yyPt1T/dEjvq/gju
         lqHFzhmzBJWkvpF77VzAfR3Iqj0SXJ8p3lONSxnUgqRaZxRd5m0VBJaAdS0kUuieL9
         lPGjR6QQYdhAWfUEJMtPC1xldo5eapzQch6lHZMXjLpmmLPwo7M/rUTCEPpJxhHTIB
         P3mAO7DClOkMw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Fox Chen <foxhlchen@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Neil Brown <neilb@suse.de>, vegard.nossum@oracle.com,
        Al Viro <viro@zeniv.linux.org.uk>, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
In-Reply-To: <CAC2o3DLJpMJDzQByJixPyLe47ajXXVFPRQBh3MaYPargrqS4tg@mail.gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-2-foxhlchen@gmail.com>
 <20210419021730.GV2531743@casper.infradead.org>
 <CAC2o3D+kq+U9vSp_9DNM3UGA=UGhS84Y+mwm=9S6eMPpf2-ogQ@mail.gmail.com>
 <20210419032513.GW2531743@casper.infradead.org>
 <CAC2o3DLJpMJDzQByJixPyLe47ajXXVFPRQBh3MaYPargrqS4tg@mail.gmail.com>
Date:   Mon, 19 Apr 2021 13:22:31 -0600
Message-ID: <87fszmaxl4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fox Chen <foxhlchen@gmail.com> writes:

> On Mon, Apr 19, 2021 at 11:25 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Mon, Apr 19, 2021 at 10:33:00AM +0800, Fox Chen wrote:
>> > On Mon, Apr 19, 2021 at 10:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>> > > You can drop ``..`` from around function named which are followed with
>> > > ().  d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
>> > > marks them up automatically.
>> > >
>> >
>> > Got it, thanks for letting me know. But I will still use them in this
>> > patch series to keep consistency with the remaining parts of the
>> > document.
>>
>> Well, you weren't.  For example:
>>
>> +As the last step of ``walk_component()``, ``step_into()`` will be called either
>> +directly from walk_component() or from handle_dots().  It calls
>> +``handle_mount()``, to check and handle mount points, in which a new
>>
>> Neither of the functions on the second line were using ``.
>
> Oh, That was a mistake,  They should've been wrapped with ``.
> Thanks for pointing it out. I will go through the whole patch set and
> fix this type of inconsistency in V3.

Please, if possible, go toward the bare function() form rather than
using literals...it's easier to read and the docs system will
automatically create cross references for you.

Thanks,

jon
