Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035AA35E0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbhDMODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:03:06 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:31998 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345047AbhDMOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:46 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d76 with ME
        id sE2N2400F21Fzsu03E2NeZ; Tue, 13 Apr 2021 16:02:24 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Apr 2021 16:02:24 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in
 'cs35l35_i2c_probe()'
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org,
        tiwai@suse.com, james.schulman@cirrus.com, david.rhodes@cirrus.com,
        linux-kernel@vger.kernel.org
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
 <20210413124323.GD5586@sirena.org.uk>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <3f276ab6-1704-84ed-3681-d639ba1e0010@wanadoo.fr>
Date:   Tue, 13 Apr 2021 16:02:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413124323.GD5586@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/04/2021 à 14:43, Mark Brown a écrit :
> On Sun, Apr 11, 2021 at 02:51:06PM +0200, Christophe JAILLET wrote:
>> If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
>> return directly as already done by the surrounding error handling paths.
> 
> These are stylistic improvements rather than bug fixes so it's probably
> better not to call them fixes.
> 

Ok, agreed.
The error handling path is a no-op in such a case.

What do you prefer:
   - you fix the subject?
   - I send a v2 with a new subject?
   - we leave it as-is as this patch is a no-op in the real world? So it 
doesn't really mater.

CJ
