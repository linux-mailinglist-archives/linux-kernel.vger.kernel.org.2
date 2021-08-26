Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB13F9117
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbhHZXrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 19:47:12 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52645 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243886AbhHZXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 19:47:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3966D320046E;
        Thu, 26 Aug 2021 19:46:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Aug 2021 19:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0bAX2q
        B9NKBGTe2XmYqyZU75YUOSdQQ4htXN/uBNGJc=; b=rAj70LGKCEkcs3JhImZz5Y
        52/OMQ7Ps1RobBlvwJUINC2ZOUuClJ5xHUcle9rzTL4D0bu2bvOiOOsPEvfuYRAr
        rmHmIRikFB6I7uMp6CNWKqkQiN1uKW9QOLcOSU6m1u1WJ4do3mJKQIvxnM2GbJRN
        JbV16gy/zjiYe1aaGKHqSEhCahKluYoSixaSU5uy3xXrsXZGoAuq6Nn3UcyqB2Dr
        yxv8qolrI8a+CFcDHDsZPFopYRD9dJZLhBDhKLq7pAfhx8Q4U1Vw13+J7LmfazYa
        yxONWgC7dPG/NSN8cXKHvroo9M8C+Ypq3tX3SKs5iezQUItF90LVYx+/eAGAuA5w
        ==
X-ME-Sender: <xms:xycoYUNK1Oz7YJhNP-RLPnzuaJ7bRKfBdGpeYtlT1-kUbsVSe906JQ>
    <xme:xycoYa_s1Wh3lCQRkiTXGNMBiig2DQqHDerzfh5_k-9lEZrIBqZcMJHyA48igTuao
    3IaNumVN_3-GUuVQ7Y>
X-ME-Received: <xmr:xycoYbRYb8DQlG2ZNZTwZCgljrsh7M_OwgAdmQGEs3CGLWKXJYtAx1GUTMbH5dB4M8RPGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduvddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesthdtre
    dtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfeffedufffhgfeuheegffffgeegveeifeeute
    fhieejffetudfgueevteehtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:xycoYcvo7Rvd8A6pR_27qC6t0lN55RVbWD8C0_Pz1rq907Ghr02yGg>
    <xmx:xycoYcdE2oQL-5bXLYq8rOWrce8cI2Zt67K7zQodl0t_qQags3Bn4w>
    <xmx:xycoYQ2vFCUFEkhMvCNrult9FKdwvFd5iQdP5m-17kDyWmsEuVF0TA>
    <xmx:xycoYYEi7zIVNXtrvVByqAvwk28oz6UuxQARkYY5oWC1yvCPXiN4gw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Aug 2021 19:46:11 -0400 (EDT)
Date:   Fri, 27 Aug 2021 11:45:56 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v5 0/1] asus-wmi: Add support for custom fan curves
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <KO0HYQ.H02HYMA788G12@ljones.dev>
In-Reply-To: <20210826234259.5980-1-luke@ljones.dev>
References: <20210826234259.5980-1-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 27 2021 at 11:42:58 +1200, Luke D. Jones <luke@ljones.dev> 
wrote:
> Add support for custom fan curves found on some ASUS ROG laptops.
> 
> The patch has gone through a few revisions as others tested it and
> requested bahaviour changes or reported issues. V4 should be 
> considered
> finalised for now and I won't submit a new version until V4 has been
> reviewed.

Sorry, I copy/pasted my last log. This V5 is pretty much finalised now. 
Testing and self-review seems to have caught everything it possibly can.

Cheers,
Luke.

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
> - V5
>   + Remove an unrequired function left over from previous iterations
>   + Ensure default curves are applied if user writes " " to a curve 
> path
>   + Rename "active_fan_curve_profiles" to 
> "enabled_fan_curve_profiles" to
>     better reflect the behavious of this setting
>   + Move throttle_thermal_policy_write_*pu_curves() and rename to
>     fan_curve_*pu_write()
>   + Merge fan_curve_check_valid() and fan_curve_write()
>   + Remove some leftover debug statements
>   + Remove '\n' causing double-up of '\n\n'
> 
> Luke D. Jones (1):
>   asus-wmi: Add support for custom fan curves
> 
>  drivers/platform/x86/asus-wmi.c            | 618 
> ++++++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>  2 files changed, 619 insertions(+), 1 deletion(-)
> 
> --
> 2.31.1
> 


