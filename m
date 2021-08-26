Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F03F90DD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243758AbhHZXKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 19:10:40 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40355 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243730AbhHZXKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 19:10:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DD0A73200913;
        Thu, 26 Aug 2021 19:09:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Aug 2021 19:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WicrDQ
        NMFtRrmhlxsbtDEgZ4d37oA1zORnCzZCHcbYc=; b=nXA6mtfDfGYlyZnVkRJwtX
        C230gfwRghY8M6+/Nptf7P8+eV/pvJL11p85L4JVoQ4WZx2QapwSAo70XROffnC5
        e8ubifjuAm61oAtFR5ikIJkdwIITEfIE+hH87pgBkowG74uXRHAGMivR2Q2CQq40
        hzAddlWE9gTRLEZ3eNi5aTbcx0Rx1pAeYYssYReKqB5P4kqKX539DlPTW+qGh2Tj
        eKuOpNTaqc50Qt+tbRb0GoekfFi2O3/HaiUqCHgzc788vLMshDljGlT1fvgYnfux
        SV6iMokOhP08TJAzG0fOo5egl7EaqpcfWsl7lXVClcb6DHtftxq8yPbLhNoHHTfA
        ==
X-ME-Sender: <xms:PR8oYULVKSAFQc_ybe3-HCGpxvRMUnanRUgdG0nzvIZKp-nYv14c5Q>
    <xme:PR8oYUI1N2Q1Wj8mmL1LhfyJQhoS9q9zWNvoP8LcwggmlIsNWJ04uHr9MI1H78Ed7
    ocuw-0JObUWp8wbU9A>
X-ME-Received: <xmr:PR8oYUtRk5FfxX1H5YpptaDdCiJ2oNJhIkm64_q4TZ6h6SQLNIraEyIEFvqmhldfL1ZMXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesthdtre
    dtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfeffedufffhgfeuheegffffgeegveeifeeute
    fhieejffetudfgueevteehtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:PR8oYRZrypY01sx6KyXwGA8Ah5tR_LO3or6DSqWvmR2qzdoCfTS4zA>
    <xmx:PR8oYbYg8RhAlEYQ4w5ioZNr5nV83oNtg_28sCIKU_0U73vYESEhjA>
    <xmx:PR8oYdANvb64DhbFNZtwsMdtVR2I6tYzHy5-NVHa57eQe6mUVfObdQ>
    <xmx:Ph8oYSyDH2gV8qwXLIjKIg_4v7YbL-FlkJHqThwMNgDQZ_jXBLftDA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Aug 2021 19:09:45 -0400 (EDT)
Date:   Fri, 27 Aug 2021 11:09:28 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 0/1] asus-wmi: Add support for custom fan curves
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <SZYGYQ.22JW11Y1CJIC3@ljones.dev>
In-Reply-To: <20210820095726.14131-1-luke@ljones.dev>
References: <20210820095726.14131-1-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will be submitting a V5 later today. While prepping for v5 I've done 
my best to minimise potential blockers in review according to what I've 
learned through past reviews :)

On Fri, Aug 20 2021 at 21:57:25 +1200, Luke D. Jones <luke@ljones.dev> 
wrote:
> Add support for custom fan curves found on some ASUS ROG laptops.
> 
> The patch has gone through a few revisions as others tested it and
> requested bahaviour changes or reported issues. V4 should be 
> considered
> finalised for now and I won't submit a new version until V4 has been
> reviewed.
> 
> - V1
>   + Initial patch work
> - V2
>   + Don't fail and remove wmi driver if error from
>     asus_wmi_evaluate_method_buf() if error is -ENODEV
> - V3
>   + Store the "default" fan curves
>   + Call throttle_thermal_policy_write() if a curve is erased to 
> ensure
>     that the factory default for a profile is applied again
> - V4
>   + Do not apply default curves by default. Testers have found that 
> the
>     default curves don't quite match actual no-curve behaviours
>   + Add method to enable/disable curves for each profile
> 
> Luke D. Jones (1):
>   asus-wmi: Add support for custom fan curves
> 
>  drivers/platform/x86/asus-wmi.c            | 672 
> +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>  2 files changed, 674 insertions(+)
> 
> --
> 2.31.1
> 


