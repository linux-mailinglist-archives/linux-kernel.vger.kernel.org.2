Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D2392168
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhEZUX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:23:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhEZUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DPj/QC3tPB6BzGxbS/g/QLvZ/1F9Y3CqrmAaq2fv7Oc=; b=P6TOIZ0QLkwA75WftXOs1yjkKc
        W1Ou2PevK9UDPpfYzuM+4T5Nwv4Uqu6wUsX3wlBl++3B2c10qCXDqxo1YN4fFuLZDqKuyTDCyCrp6
        /RRYISK8O4tU/02K0aevA4YS8Ia0tGkcXT/bgKo2/4TJgqw4UjQlA7JqLXpBlBkSmWNU=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lm02J-0067nm-3h; Wed, 26 May 2021 20:21:51 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4D9DCD0E9E6; Wed, 26 May 2021 21:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        Andrei Drimbarean <andrei.drimbarean@analog.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: [PATCH] regmap: add support for 7/17 register formating
Date:   Wed, 26 May 2021 21:21:47 +0100
Message-Id: <162206049368.1916831.4222426615853271244.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526085223.14896-1-antoniu.miclaus@analog.com>
References: <20210526085223.14896-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Wed, 26 May 2021 11:52:24 +0300, Antoniu Miclaus wrote:
> This patch adds support for 7 bits register, 17 bits value type register
> formating. This is used, for example, by the Analog Devices
> ADMV1013/ADMV1014.

Applied, thanks!

[1/1] regmap: add support for 7/17 register formating
      commit: b24412aff37c58286a0aeafc5678fbdc6a527d54

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
