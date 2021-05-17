Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A1382A80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhEQLEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:04:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236514AbhEQLEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:04:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70B4FAE89;
        Mon, 17 May 2021 11:03:04 +0000 (UTC)
Subject: Re: [PATCH 3/9] arm64: dts: rockchip: Prepare Rockchip RK1808
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20210516230551.12469-1-afaerber@suse.de>
 <20210516230551.12469-4-afaerber@suse.de>
 <f46625ed-4c83-9fd2-52cd-e07a4d93a254@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <3f5767aa-77c4-6007-adfa-a85bf0a7e9ad@suse.de>
Date:   Mon, 17 May 2021 13:03:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f46625ed-4c83-9fd2-52cd-e07a4d93a254@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 17.05.21 03:29, Johan Jonker wrote:
> Send the complete serie to all maintainers and mail lists.

That's unhelpful - all patches went to linux-rockchip, LAKML and LKML,
and get_maintainers.pl was used. The cover letter was explicitly copied
to DTML as get_maintainers.pl doesn't catch it. You'll find them here:

https://lore.kernel.org/linux-rockchip/20210516230551.12469-1-afaerber@suse.de/

Which mailing list or maintainer do you think all should've gone to in
addition? You're not listed anywhere in linux-next MAINTAINERS. If you
want to be CC'ed, you can nicely ask me to for a v2 (and explaining why
would help for the next series), or you can send patches against
MAINTAINERS yourself.

Copying all maintainers and lists would likely not be appreciated by the
colleagues and may get mails flagged as spam.

> ===
> Heiko's sort rules:
> 
> compatible
> reg
> interrupts
> [alphabetical]
> status [if needed]
> 
> ===
> My incomplete list:
> 
> For nodes:
> If exists on top: model, compatible and chosen.
> Sort things without reg alphabetical first,
> then sort the rest by reg address.
> 
> Inside nodes:
> If exists on top: compatible, reg and interrupts.
> In alphabetical order the required properties.
> Then in alphabetical order the other properties.
> And as last things that start with '#' in alphabetical order.
> Add status below all other properties for soc internal components with
> any board-specifics.
> Keep an empty line between properties and nodes.
> 
> Exceptions:
> Sort pinctrl-0 above pinctrl-names, so it stays in line with clock-names
> and dma-names.
> Sort simple-audio-card,name above other simple-audio-card properties.
> Sort regulator-name above other regulator properties.
> Sort regulator-min-microvolt above regulator-max-microvolt.
> 
> ===


Here's a rule for you: No top-posting on kernel lists.


> 
> Fix complete dtsi for property sort order!
> Add more drivers. (cru, pinctrl)

-ETONE! I don't work for Rockchip, so don't command me to add drivers
for them that I have no source code for (cover letter) nor complete TRM.
You're welcome that I did this service to the kernel community in my
spare time... If you look up the date of Hackweek 20, you'll find that
it took me two months to get this patchset binding-documented and
cleaned up to this point, so by extrapolation it's unrealistic to expect
much more of me here anytime soon. Rudeness certainly does not motivate.

Heiko knows me - if he has any comments, he should be well capable of
voicing them himself inline. I will not follow nonsensical rules that
diverge from other mainline arm-soc vendors - unless I've missed some
new directive from Rob or arm-soc maintainers that would apply to all.

Thanks for nothing,

Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
