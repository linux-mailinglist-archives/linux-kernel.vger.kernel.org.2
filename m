Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991DF434563
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJTGtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:49:03 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:49512 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:49:02 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id B56B9842;
        Wed, 20 Oct 2021 14:46:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.22] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16835T140562797250304S1634712383778350_;
        Wed, 20 Oct 2021 14:46:24 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: jay.xu@rock-chips.com
X-RCPT-COUNT: 11
X-LOCAL-RCPT-COUNT: 1
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <0e98d8f1b9ab8a8b4cd160bf98629cb4>
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_ASoC=3a_rockchip=3a_use_generic_DMA_eng?=
 =?UTF-8?B?aW5lIGNvbmZpZ3VyYXRpb27jgJDor7fms6jmhI/vvIzpgq7ku7bnlLFsaW51eC1y?=
 =?UTF-8?Q?ockchip-bounces+sugar=2ezhang=3drock-chips=2ecom=40lists=2einfrad?=
 =?UTF-8?B?ZWFkLm9yZ+S7o+WPkeOAkQ==?=
To:     Mark Brown <broonie@kernel.org>
Cc:     John Keeping <john@metanate.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>
References: <20211018114844.1746351-1-john@metanate.com>
 <YW1svMVSgBJygfpV@sirena.org.uk>
 <a5eebd60-da6f-cc56-b1fe-221dc827e097@rock-chips.com>
 <YW63pduAGW01PUoj@sirena.org.uk>
From:   sugar zhang <sugar.zhang@rock-chips.com>
Message-ID: <cdd530bd-9d85-8edf-2151-00502bbbb4cf@rock-chips.com>
Date:   Wed, 20 Oct 2021 14:46:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YW63pduAGW01PUoj@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2021/10/19 20:18, Mark Brown wrote:
> On Tue, Oct 19, 2021 at 10:11:27AM +0800, sugar zhang wrote:
>> Hi Mark, John,
>>
>> Actually, I have submit patch[1] to do the same thing a few weeks ago, and
>> explain the original purpose.
>>
>> [1] https://x-lore.kernel.org/linux-rockchip/1632792957-80428-1-git-send-email-sugar.zhang@rock-chips.com/
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
ok.
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.
got it, thanks.

-- 
Best Regards!
张学广/Sugar
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.



