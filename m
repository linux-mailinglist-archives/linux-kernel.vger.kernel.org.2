Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A923F59C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhHXIUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233692AbhHXIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:20:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A718861220;
        Tue, 24 Aug 2021 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629793157;
        bh=ljn44Si2veEiRe5z9NksG9SxCXSDFFGoDCIkoXx450c=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=mT/OTkllIL66GKfXoB6TT0a2rmDsO8I6gkdJM/jCx44LXIinBR81Rii9LCDOf2ZRz
         x5Phwdyl4Yt9/spSB5mHZkgUY5AmUDdCGEbGTfHflKT6G5UMqStRoFfM/cVEQAiSml
         +xQWwkNaW08ty/IwylyBva0/NKremkSEEgOAqiSzykNWu9bzQPxnXnfbIUlX/OKypy
         IORG3OrV77Fb8XER0pG6CeCKP1Ey0mWoC+jE93x1nxdJF1YMGaJswgtJZegi0q8Pnd
         zYGJmPWrJYxlfs/j3Yndow8aKhit62CHCEFofs487C8H7G5KJzbnwK6j+to03Zi849
         XyE9fuydAAoPw==
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
 <20210823184449.2796184-2-Nehal-Bakulchandra.shah@amd.com>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
Subject: Re: [PATCH 1/2] usb: dwc3: pci: add support for AMD's newer
 generation platform.
Date:   Tue, 24 Aug 2021 11:19:02 +0300
In-reply-to: <20210823184449.2796184-2-Nehal-Bakulchandra.shah@amd.com>
Message-ID: <87tujf6yri.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:

> AMD's latest platforms has DWC3 controller. Add the PCI ID and
> properties for the same.
>
> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
