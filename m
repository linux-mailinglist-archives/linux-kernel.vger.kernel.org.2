Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0553402FE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346806AbhIGUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:49:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44976 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbhIGUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:49:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631047674; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=84xmrz2XVH3FwGCgz/JKGOKJty2YePbiyLIkDOPrV8U=;
 b=oFdyjHvZq8TTW92j9bNzcRJwCFPoVG99nGfgDf61E90hPu8F9G2Tt008ONwuoyQa8pNet2px
 QA/Rlev4yel4ANL7+aJj41nLbcTLiNcfmvZ9Xbw8npp3SP+GwNZkaV1PXeRZcHytjifjeNt/
 NybldgGp01751Yr7hzH7xbhN6kc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6137cff56fc2cf7ad94f8729 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Sep 2021 20:47:49
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88A7BC4361C; Tue,  7 Sep 2021 20:47:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A64FC43460;
        Tue,  7 Sep 2021 20:47:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 07 Sep 2021 13:47:47 -0700
From:   khsieh@codeaurora.org
To:     Lyude Paul <lyude@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, rsubbia@codeaurora.org,
        rnayak@codeaurora.org, freedreno@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/dp_mst: Fix return code on sideband message
 failure
In-Reply-To: <db5ae1c8d070509580218a501cfa9caaf3f029e1.camel@redhat.com>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
 <87zguy7c5a.fsf@intel.com> <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
 <2da3949fa3504592da42c9d01dc060691c6a8b8b.camel@redhat.com>
 <d9ec812b4be57e32246735ca2f5e9560@codeaurora.org>
 <79c5a60fc189261b7a9ef611acd126a41f921593.camel@redhat.com>
 <696a009e2ab34747abd12bda03c103c7@codeaurora.org>
 <e725235a77935184cd20dab5af55da95b28d9e88.camel@redhat.com>
 <64049ef6c598910c1025e0e5802bb83e@codeaurora.org>
 <88b5fbe60c95bcdf42353bec9f8c48aefa864a31.camel@redhat.com>
 <f0fcfe7a73e87150a7a1f042269b76a3@codeaurora.org>
 <db5ae1c8d070509580218a501cfa9caaf3f029e1.camel@redhat.com>
Message-ID: <4937c56eb3efd91a09f8293bcec3221e@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-30 09:58, Lyude Paul wrote:
> On Mon, 2021-08-30 at 08:56 -0700, khsieh@codeaurora.org wrote:
>> On 2021-08-25 09:26, Lyude Paul wrote:
>> > The patch was pushed yes (was part of drm-misc-next-2021-07-29), seems
>> > like it
>> > just hasn't trickled down to linus's branch quite yet.
>> 
>> Hi Stephen B,
>> 
>> Would you mind back porting this patch to V5.10 branch?
>> It will have lots of helps for us to support display port MST case.
>> Thanks,
> 
> I'm assuming you're talking to someone else? A little confused because 
> I don't
> see a Stephen B in this thread

Yes,
I am asking Stephen B (swbody@chromium.org) helps to back port this 
patch to v5.10.
> 
>> 
>> 
>> 
>> >
>> > On Wed, 2021-08-25 at 09:06 -0700, khsieh@codeaurora.org wrote:
>> > > On 2021-07-27 15:44, Lyude Paul wrote:
>> > > > Nice timing, you literally got me as I was 2 minutes away from leaving
>> > > > work
>> > > > for the day :P. I will go ahead and push it now.
>> > > >
>> > > Hi Lyude,
>> > >
>> > > Had you pushed this patch yet?
>> > > We still did not see this patch at msm-nex and v5.10 branch.
>> > > Thanks,
>> > >
>> > >
>> > > > BTW - in the future I recommend using dim to add Fixes: tags as it'll
>> > > > add Cc:
>> > > > to stable as appropriate (this patch in particular should be Cc:
>> > > > stable@vger.kernel.org # v5.3+). will add these tags when I push it
>> > > >
>> > > > On Tue, 2021-07-27 at 15:41 -0700, khsieh@codeaurora.org wrote:
>> > > > > On 2021-07-27 12:21, Lyude Paul wrote:
>> > > > > > On Thu, 2021-07-22 at 15:28 -0700, khsieh@codeaurora.org wrote:
>> > > > > > >
>> > > > > > > It looks like this patch is good to go (mainlined).
>> > > > > > > Anything needed from me to do?
>> > > > > > > Thanks,
>> > > > > >
>> > > > > > Do you have access for pushing this patch? If not let me know and
>> > > > > > I
>> > > > > > can
>> > > > > > go
>> > > > > > ahead and push it to drm-misc-next for you.
>> > > > > no, I do not have access to drm-misc-next.
>> > > > > Please push it for me.
>> > > > > Thanks a lots.
>> > > > >
>> > >
>> 
