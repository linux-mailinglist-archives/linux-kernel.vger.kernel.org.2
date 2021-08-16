Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC33EDB28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhHPQnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:43:40 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42014
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhHPQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:43:38 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F07123F04D;
        Mon, 16 Aug 2021 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629132186;
        bh=0Aci3PtlGfoMUvbObF/5DAnE61QA6srUCQf5qmnkZSs=;
        h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type;
        b=s7Q8jp6iDjOscuUyTOeoDhes/D3AdsCB/AsTwmX+AiT+Am3c7PgzvmRtKDZQHJ0mD
         iwO7JU1lmV92Nxg56z1VRrYR2GnNOiQG8YTIHWiDdf2QRaUlbdeU+Gqq7VKMDV9x/+
         ZnV0Ur40kAJoVRdepgSAUhPUVDpK/SLjo+1Q+hZIaysFVRLsY1uW0chwbcxb7CbFqo
         GIUO8OAgJQmHyT7WPB8esfy/+O1e17gToO83xUO1AS0yUMlmqQkV5J5nfussflOOST
         0jQaM+weVM1dFtM6pzAnbSQ9uOjZ9T2LADtzHKVXqCjLThDknxGWXtL8D2M0RKgBDZ
         pSh4JxbV4kX4Q==
From:   Colin Ian King <colin.king@canonical.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Subject: re: ASoC: sh: Add RZ/G2L SSIF-2 driver
Message-ID: <962029d0-d001-f85c-1676-262372faeb34@canonical.com>
Date:   Mon, 16 Aug 2021 17:43:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis on linux-next with Coverity has detected an issue in
rz_ssi_stop, sound/soc/sh/rz-ssi.c with the following commit:

commit 03e786bd43410fa93e5d2459f7a43e90ff0ae801
Author: Biju Das <biju.das.jz@bp.renesas.com>
Date:   Fri Aug 13 10:11:54 2021 +0100

    ASoC: sh: Add RZ/G2L SSIF-2 driver


The analysis is as follows:

367
368        /* Wait for idle */
369        timeout = 100;
370        while (--timeout) {

Wrong operator used (CONSTANT_EXPRESSION_RESULT)

operator_confusion: rz_ssi_reg_readl(ssi, 4) | (33554432UL /* 1UL << 25
*/) is always 1/true regardless of the values of its operand. This
occurs as the logical operand of if.

371                if (rz_ssi_reg_readl(ssi, SSISR) | SSISR_IIRQ)
372                        break;
373                udelay(1);
374        }

I suspect the & operator was intended to mask the specific bit. However
I'm not sure if the intent is to detect if the SSISR_IIRQ bit should be
zero or one at the point where the break should occur, hence I'm
reporting this issue.

Colin
