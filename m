Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E334D636
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC2Rne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhC2RnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:43:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B61C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:43:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso5537650pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Z6t4O1RYVUyxfnLHWVRPLJFIbpkzHLyD7hxqplzKA4M=;
        b=gLMohOAGYhCGb6LRh6BSEina138WNXhAys9t8Oc4R2GhmbTB3EeFsp16Pg6YbniYGN
         MqlJ2WdU6OvpeHEPizCrcgHdMt2yWp4CrQbBTkp0tDcY6hadne66FYLx3LvmMnxGK7CT
         2LpYVqJjkntMOJF9DiTyjvs48CW2EklqivnXyo8fOG21UBK3rh3ETCudY73pJ39vGPU1
         OMXnjAUrD9Qef55KxyPlafcV6cf+NPpb6ueeXR2UOFgRY24NIgVhTVOH8EV6Ip3nPt4v
         EbiL2IhyW/NbFTIBwxVGDIp81LebVBrxJ/v534CpmXKPvrzmZv8UBkIGOLbWKd0a4hJk
         NgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Z6t4O1RYVUyxfnLHWVRPLJFIbpkzHLyD7hxqplzKA4M=;
        b=HYFhzXSQp52hXM5ctIuZeAGTv8Rk9JvkOa/TeQp0NekfT0JGeOVrEGx6YZj8fFIjom
         +Eg/L0tue9IaTt1g4PepKR+Dcf66aX/ENLq4hOZRBs0xu/svuGvJW0VVpny5yQx50Nq8
         Nyl5d7JzCwvs7pa+mu4YTlaeEIZAyogZNGStF5963/+hv+4jxIWjg6hH/sSc3m9l21vj
         r7/K64lCNV+vMIDr37aijODV2gvGRvn81Kc1sVXMGN637jKagtvZOhfdEckXJA5wwfqJ
         WzOsCVhCFK3dckapZ9n/AbF50ThG+noY2YFsN54FUJTloHyuB0L3QFOGmnlznt70wh5O
         aUPg==
X-Gm-Message-State: AOAM531Ll7mS+iAjRLnrUTCFGRI1fL4O67XnKFPC5CeW0C/SSTIjlq/r
        EkeRx73UNRtnu4ApFWOaUcAT8g==
X-Google-Smtp-Source: ABdhPJyhxU9RzMMXlogKIDMvRFNS8XrXutmNrsOIY/4iBlP04fOsR7l8yS6aHgFEHYEgZ6nI3qwHNA==
X-Received: by 2002:a17:90b:ecd:: with SMTP id gz13mr218628pjb.219.1617039790046;
        Mon, 29 Mar 2021 10:43:10 -0700 (PDT)
Received: from ?IPv6:2600:1010:b06a:1311:e806:6d31:5a5:2c5c? ([2600:1010:b06a:1311:e806:6d31:5a5:2c5c])
        by smtp.gmail.com with ESMTPSA id g10sm16590978pgh.36.2021.03.29.10.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 10:43:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
Date:   Mon, 29 Mar 2021 10:43:05 -0700
Message-Id: <09AB34BD-7DB8-4DBD-A538-F3AE642F8C8A@amacapital.net>
References: <CAJvTdKm4qKw8D8b+NokBsdiE5yBj=LTiH50VuxJY2aAL8qQq6g@mail.gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJvTdKm4qKw8D8b+NokBsdiE5yBj=LTiH50VuxJY2aAL8qQq6g@mail.gmail.com>
To:     Len Brown <lenb@kernel.org>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 29, 2021, at 9:06 AM, Len Brown <lenb@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Mar 29, 2021 at 11:43 AM Len Brown <lenb@kernel.org> wrot=
e:
>>=20
>> On Mon, Mar 29, 2021 at 9:33 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
>>=20
>>>> I found the author of this passage, and he agreed to revise it to say t=
his
>>>> was targeted primarily at VMMs.
>>>=20
>>> Why would this only a problem for VMMs?
>>=20
>> VMMs may have to emulate different hardware for different guest OS's,
>> and they would likely "context switch" XCR0 to achieve that.
>>=20
>> As switching XCR0 at run-time would confuse the heck out of user-space,
>> it was not imagined that a bare-metal OS would do that.
>=20
> to clarify...
> *switching* XCR0 on context switch is slow, but perfectly legal.

How slow is it?  And how slow is switching XFD?  XFD is definitely serializi=
ng?
