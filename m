Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770B63F79DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhHYQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:07:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57778 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhHYQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:07:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629907584; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=yc5dXmEbANnSyJ5gTovdFTL4dL+lLozkExAzl2y9EgI=;
 b=tqNWiM3urqPxPKl2PZ8MKvWBg2fapeQGFLx9+bcOF1XwdC47YJRf+24tF7U2ZnyBsbF78ZQf
 Xa45Z50Wlsg/IY1XalbITBuuOBvpuLTU1Sio1PPKdeGmuKT2Ogv6CTLjFTnWO3AAtrZfDeRP
 ouwWzqM44VbNSDSY3qqzngtmhbY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61266a6b40d2129ac164b0e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 16:06:03
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10A15C43638; Wed, 25 Aug 2021 16:06:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B4E6C4361A;
        Wed, 25 Aug 2021 16:06:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 25 Aug 2021 09:06:02 -0700
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
In-Reply-To: <e725235a77935184cd20dab5af55da95b28d9e88.camel@redhat.com>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
 <87zguy7c5a.fsf@intel.com> <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
 <2da3949fa3504592da42c9d01dc060691c6a8b8b.camel@redhat.com>
 <d9ec812b4be57e32246735ca2f5e9560@codeaurora.org>
 <79c5a60fc189261b7a9ef611acd126a41f921593.camel@redhat.com>
 <696a009e2ab34747abd12bda03c103c7@codeaurora.org>
 <e725235a77935184cd20dab5af55da95b28d9e88.camel@redhat.com>
Message-ID: <64049ef6c598910c1025e0e5802bb83e@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-27 15:44, Lyude Paul wrote:
> Nice timing, you literally got me as I was 2 minutes away from leaving 
> work
> for the day :P. I will go ahead and push it now.
> 
Hi Lyude,

Had you pushed this patch yet?
We still did not see this patch at msm-nex and v5.10 branch.
Thanks,


> BTW - in the future I recommend using dim to add Fixes: tags as it'll 
> add Cc:
> to stable as appropriate (this patch in particular should be Cc:
> stable@vger.kernel.org # v5.3+). will add these tags when I push it
> 
> On Tue, 2021-07-27 at 15:41 -0700, khsieh@codeaurora.org wrote:
>> On 2021-07-27 12:21, Lyude Paul wrote:
>> > On Thu, 2021-07-22 at 15:28 -0700, khsieh@codeaurora.org wrote:
>> > >
>> > > It looks like this patch is good to go (mainlined).
>> > > Anything needed from me to do?
>> > > Thanks,
>> >
>> > Do you have access for pushing this patch? If not let me know and I can
>> > go
>> > ahead and push it to drm-misc-next for you.
>> no, I do not have access to drm-misc-next.
>> Please push it for me.
>> Thanks a lots.
>> 
