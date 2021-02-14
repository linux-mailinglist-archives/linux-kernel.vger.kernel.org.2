Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518C31B26D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhBNUd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhBNUbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:31:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8EC964E07;
        Sun, 14 Feb 2021 20:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613334738;
        bh=hjAz5d+qbxoXEq420RmleWCQIeEnvdi17FPWs6qwda8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IxSBnZqLdpzo8rraRIHe0tvCYQbKDNWmyXJqR/LU6klUROInjREIew+aBQmCJLSQp
         tIf4PJccyLwT/wx7Z4JB8qHDjjXucVRxt1ojg6CVCTyznVZ7hLAkZPoOV6vTPeXJZL
         rIfVRfjW8MjUdHx96q0VXamHw3YaESM2MsAKLOlhRI9Z0oAKJmJnBHENd9o71dgwpE
         Gbfi2ZMi0IdQzb01AXkO2K7dmwC3xeNERPuVxY6+EB+iUBI1zx9q2icXegUDxjq8j/
         Tmuiw8je98WQbTpdTdSuAQVQvzjV+6y55lILkAbKrCEWLMlsJMP8qKp2kXIVrX59pI
         ddH6rMJzmnN6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210211052206.2955988-5-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com> <20210211052206.2955988-5-daniel@0x0f.com>
Subject: Re: [PATCH v2 4/7] clk: mstar: MStar/SigmaStar MPLL driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
To:     Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sun, 14 Feb 2021 12:32:17 -0800
Message-ID: <161333473746.1254594.8116415179063395207@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2021-02-10 21:22:03)
> This adds a basic driver for the MPLL block found in MStar/SigmaStar
> ARMv7 SoCs.
>=20
> Currently this driver is only good for calculating the rates of it's
> outputs and the actual configuration must be done before the kernel
> boots. Usually this is done even before u-boot starts.
>=20
> This driver targets the MPLL block found in the MSC313/MSC313E but
> there is no documentation this chip so the register descriptions for
> the another MStar chip the MST786 were used as they seem to match.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---

Applied to clk-next
