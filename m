Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF733E2A58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbhHFMI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 08:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343565AbhHFMI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7171560EBC;
        Fri,  6 Aug 2021 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628251692;
        bh=LVPsGWT1ar/fDJEE1pmUbpOVCKR/2+4qXoS/EGf8FhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdxTHdC4Gq9n66tBqkFq8X6HcXqdvAvyAkoRQNggiiWsv1s3DYHZdML4lt9K43h1U
         Zyh88t3JAtimgvfhNKzyHIjKbN2ht2mqz7iBfJgBhOgPko/fl1+HZbxICgbNDm4LDQ
         jkOc4o+lyFForptMxD5R5YTtSU2VBudJa5Rt0Y/6TdfwLRxhvfEMgTk2cRux08GWw5
         uV2Io7CplCGP++rpR9c5MwksSigatoFYnDSP11EvrllljvgO312f1vVdqzEKud0sH2
         sOi4bzjyErEF7tjl3qhgdbaJfoCzF7Ir02PFDAkagThSd8y38SCmC8RodLXfAc9cd9
         W7Sd2B2qpXoBQ==
Date:   Fri, 6 Aug 2021 17:38:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, lokeshvutla@ti.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: Convert AM654 SERDES bindings to YAML
Message-ID: <YQ0mKEfb22XcK7gl@matsya>
References: <20210723135605.23572-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723135605.23572-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-21, 19:26, Kishon Vijay Abraham I wrote:
> Convert SERDES dt-bindings for TI's AM654 SoC to YAML binding.

Applied, thanks

-- 
~Vinod
