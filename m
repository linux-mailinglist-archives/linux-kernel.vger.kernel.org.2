Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB592430879
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245595AbhJQLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245590AbhJQLr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:47:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AAFF61247;
        Sun, 17 Oct 2021 11:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634471118;
        bh=ayI/BsDuhmTL6/MoN5FKsc8wItRlW7Q+QmyNwHSEGV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffeu4mdnudvjUjwc7aGH64aQHJ9GmG1LowOVGKwt1r5WRkJruNJxHRIiYLRtIvBJg
         RAOJtFYyVG3jNBj9MEWBkrcxCi4IQigxRjuCBD4cEmYfTaUtJUlEiz9SJUlJiSHKQh
         Ti7U5OwdJZhisWkv0QFTflC1ZK46w4s6mAZCToVQHCP6QUiIpqYfOVZzcgtGbGPWUf
         fkfqO9MiNKMAWTb7bEQQRJnKADfEiJ5vk61K3n4t+zyNLKQt4HjOGkCgXatLS74kCF
         eogxxBD9byLuAKBsRX6343pa05/wUFgskdugPYrB2kPpRu8/PMkOV8ZVloONN1rEEw
         V5UEdUHlOFpxw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH] regulator/lp872x: replacing legacy gpio interface for gpiod
Date:   Sun, 17 Oct 2021 12:45:07 +0100
Message-Id: <163447061172.1864174.17204540379675928037.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YWma2yTyuwS5XwhY@fedora>
References: <YWma2yTyuwS5XwhY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 12:14:35 -0300, Maíra Canal wrote:
> Removing all linux/gpio.h and linux/of_gpio.h dependencies and replacing
> them with the gpiod interface
> 
> 

Applied, thanks!

[1/1] regulator/lp872x: replacing legacy gpio interface for gpiod
      commit: 72bf80cf09c4693780ad93a31b48fa5a4e17a946

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
