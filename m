Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3B3380953
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhENMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232671AbhENMUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:20:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6998261285;
        Fri, 14 May 2021 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620994781;
        bh=V11qpJGiSFU2suJ6fHpZCzrX8IT+2tiHhnBdSWMUDoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDQtbqRnfqzzgS44dEi4QKjESkrnguSsovsEuYAagZkuqVRG+6PbRN8ystMOoiSuF
         mYimPLY1/IfXl1SKFtC06iRKNL36RlzvJM6gcVN8Hny1ZtUbWxtFv6CRdftcaOwzii
         aokHMLK4zSQZcjcTBcfBTF56xQ1T3L//LS448llLkWrhTwNP+cevBclVkJlH/gWnQu
         BlIvQwrNabcLh/Slh2mllSJjVDLcZ/g9DEZo2SZfpS0QODU0sGTOKQigtG5bznVG73
         punPCl/Z2AjigKb8obpFdRJBcrA9QnIwvOpw6aeNCFifUjYoJXSH7g+AOgNYaddvLK
         5I9ctoSEXQeHQ==
Date:   Fri, 14 May 2021 17:49:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sebastian Fricke <sebastian.fricke@posteo.net>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] phy: phy-core-mipi-dphy.c: Correct reference version
Message-ID: <YJ5q2fSH4r8ENVzm@vkoul-mobl.Dlink>
References: <20210421041740.8451-1-sebastian.fricke@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421041740.8451-1-sebastian.fricke@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-21, 04:17, Sebastian Fricke wrote:
> The rest of the code refers to version 1.2 of the MIPI D-PHY
> specification. But this comment refers to 2.1, while a sub comment of
> the function refers to 1.2 again. Replace 2.1 with 1.2.

Applied, thanks

-- 
~Vinod
