Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4493637EEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442912AbhELWOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390525AbhELVQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 17:16:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28FA6610A5;
        Wed, 12 May 2021 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620854131;
        bh=YmwR9dj99X6orHyH6BslNwI9ZnlbhRgMO4gQzqXM/MY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XU6cC/w7uK3f5nudXlv7ecXxvTigHv7NILf0xIIAIT7En584cy2JkXdR8Qg8mL4dh
         Ysq/4WYBS+3MmyHKU48gHmtw+4xVY8J3DF6IiIKbL8vqBOb7dKGsaaQ5FQN7oShbUe
         b3Z9yQZLL8VevSbe0AIbVC8iboq1YeWKqvfmlC6RA0o0m2PiADU3VPf0JCiVYAUg3z
         ILb2qxeEq1g85W0mWqoTQjBEHdS1m7xDNVT5Rnp/T46iKI8rQQnyOJz6TODYWMxRAn
         BLixc1Z9NO0wMcW8/zu9NIY12dvaFdDoyPoBmJbKdOFSuHizmgfXuHZZUGen4+VRWn
         JdD9vDfzSVGFA==
Subject: Re: ASoC: q6dsp: q6afe: remove unneeded dead-store initialization
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Banajit Goswami <bgoswami"@codeaurora.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
References: <5935b287-5b74-84ac-3470-3b71fd69c88c@canonical.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <7b2d1562-3629-8cd3-d9a7-926c93d20e08@kernel.org>
Date:   Wed, 12 May 2021 14:15:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5935b287-5b74-84ac-3470-3b71fd69c88c@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/2021 1:12 PM, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity on linux-next has detected an issue with
> the following commit:
> 
> commit 5f1b95d08de712327e452d082a50fded435ec884
> Author: Yang Li <yang.lee@linux.alibaba.com>
> Date:   Sun Apr 25 18:12:33 2021 +0800
> 
>      ASoC: q6dsp: q6afe: remove unneeded dead-store initialization
> 
> the analysis is as follows:
> 
> 1181 int q6afe_port_stop(struct q6afe_port *port)
> 1182 {
> 1183        struct afe_port_cmd_device_stop *stop;
> 1184        struct q6afe *afe = port->afe;
> 1185        struct apr_pkt *pkt;
> 
>      1. var_decl: Declaring variable port_id without initializer.
> 
> 1186        int port_id;
> 1187        int ret = 0;
> 1188        int index, pkt_size;
> 1189        void *p;
> 1190
> 1191        index = port->token;
> 
>      2. Condition index < 0, taking false branch.
>      3. Condition index >= 127, taking false branch.
> 
> 1192        if (index < 0 || index >= AFE_PORT_MAX) {
> 1193                dev_err(afe->dev, "AFE port index[%d] invalid!\n",
> index);
> 1194                return -EINVAL;
> 1195        }
> 1196
> 1197        pkt_size = APR_HDR_SIZE + sizeof(*stop);
> 1198        p = kzalloc(pkt_size, GFP_KERNEL);
> 
>      4. Condition !p, taking false branch.
> 
> 1199        if (!p)
> 1200                return -ENOMEM;
> 1201
> 1202        pkt = p;
> 1203        stop = p + APR_HDR_SIZE;
> 1204
> 1205        pkt->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> 1206                                           APR_HDR_LEN(APR_HDR_SIZE),
> 1207                                           APR_PKT_VER);
> 1208        pkt->hdr.pkt_size = pkt_size;
> 1209        pkt->hdr.src_port = 0;
> 1210        pkt->hdr.dest_port = 0;
> 1211        pkt->hdr.token = index;
> 1212        pkt->hdr.opcode = AFE_PORT_CMD_DEVICE_STOP;
> 
>      Uninitialized scalar variable (UNINIT)
>      5. uninit_use: Using uninitialized value port_id.
> 
> 1213        stop->port_id = port_id;
> 1214        stop->reserved = 0;
> 
> the commit removed the initialization of port_id = port->id, and now we
> have a regression where stop->port_id is being assigned with a garbage
> uninitialized value in port_id.  Perhaps the fix needs reverting. As it
> stands, I don't know why clang was reporting this as an error.
> 
> Colin
> 

I suspect this patch was not made against a current tree. I sent a patch 
that resolved this and Mark picked it up so it should be in the next 
-next version:

https://lore.kernel.org/r/20210511190306.2418917-1-nathan@kernel.org/

Cheers,
Nathan
