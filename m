Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1D38ACE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbhETLvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242543AbhETLj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:39:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54DF860FEE;
        Thu, 20 May 2021 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510717;
        bh=6sNeHzmaTfp2oUzL/y7lJXqyNS2V0NsSbM2uQWLojuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CT5yuYUHYyfnTiH64Kaw7KI3/GnAjhDgW+I1xBouAdHfktSKglzAc+AqPYIDB71Fz
         9eEapLvnax61rwt2Guiyf+vFl8kKpeTIyWw7E3X/OmA7tu9w5sfxEDoQ5UKvLmlvN7
         DY9ZEczwIooQCpGLWrf0YBgEkFK9gJs+37XKoIQRiuhf2Wu6q4774X9AR29n6SNTIT
         nO/e39M9vXkj/iyw495FMnotb6/BgJOwkxKeEOpIA2sh6c6vhxQQJ/JyAOKT3OKgJv
         sTa0naSWDxXKL7Wnu0/8/6B1Nm87aWbXCduvFJ3oV/D2R2IWa2bHTjFKu7QzEzQaZV
         fdYo9a7F7TxOw==
Received: by pali.im (Postfix)
        id EA3FF9D1; Thu, 20 May 2021 13:38:33 +0200 (CEST)
Date:   Thu, 20 May 2021 13:38:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 mvebu + mvebu/dt64 3/6] firmware: turris-mox-rwtm:
 fail probing when firmware does not support hwrng
Message-ID: <20210520113833.wci7euz2xmnlbhqq@pali>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
 <20210506090802.14268-3-pali@kernel.org>
 <YJsnqUjJMehtbqgS@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJsnqUjJMehtbqgS@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 May 2021 02:56:09 Andrew Lunn wrote:
> However, i would drop the second part of the description. Making the
> Turris MOX firmware work on none Turris MOX hardware is a new feature,
> and so not applicable to stable.

Done in v4.
