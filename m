Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2314385B3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 00:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhJWWE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 18:04:57 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:54885 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhJWWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 18:04:56 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E38F5C91A1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 21:55:46 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2DA44C0005;
        Sat, 23 Oct 2021 21:55:24 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH v1 1/3] rtc: tps80031: Remove driver
Date:   Sat, 23 Oct 2021 23:55:23 +0200
Message-Id: <163502611461.410492.13519754361719482334.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021192258.21968-2-digetx@gmail.com>
References: <20211021192258.21968-1-digetx@gmail.com> <20211021192258.21968-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 22:22:56 +0300, Dmitry Osipenko wrote:
> Driver was upstreamed in 2013 and never got a user, remove it.
> 
> 

Applied, thanks!

[1/3] rtc: tps80031: Remove driver
      commit: 005870f46cf6f98417ec48d129721e945dfb3a43

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
