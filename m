Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD104000C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhICNwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 09:52:11 -0400
Received: from mail.antaris-organics.com ([91.227.220.155]:59166 "EHLO
        mail.antaris-organics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhICNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:52:10 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Sep 2021 09:52:09 EDT
Date:   Fri, 3 Sep 2021 15:45:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
        s=202107; t=1630676737;
        bh=GEw5LRX05YII77LHOcdWYfVKOASPIApcdW7CCofxy4M=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=SjZFm4sXA57xm/p5Pl1zL21yZ4oMioY+7JkTUYZ8ZwURNbolgmjSWxt9jW2PsW3OY
         5KOk9aLKwkTySfqDa/OI2dOv442+4wx9OrwuZz4KnuNKLpcpQdYF98grP2JU4hlr2k
         JnHARt1sYYVTG7h162zL0CV4HKg0V47xCHpboNKK4vSGqNKV7IGE2Lya5+fv2mlTv2
         NThTtQCJWXWMfRiYonTKuvU1uRFnYyM3d/phomvOH9lzaehHPtMJpldYVHG+cjkPvy
         iJ3fUAHjHi6RBDsXH/Rgv58nGFua81ba5gOpAKPFQt/X3GXPu0Tpl9QAmNmMfG/0bb
         hZlLIRGJswB2w==
From:   Markus Reichelt <ml@mareichelt.com>
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Announce loop-AES-v3.7v file/swap crypto package
Message-ID: <YTInARwc6VQwb03I@pc21.mareichelt.com>
Mail-Followup-To: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <PQplWSwNm79Lk3NFH1VY9N9KAzVUf5MPJ9JyTZ5FE-oqsUB7ZKQzBi4feLDgmWSZMLz8iEbt8JgdBaPfe8eyZ-mOy07SnR6Z1lYBo-llPKI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PQplWSwNm79Lk3NFH1VY9N9KAzVUf5MPJ9JyTZ5FE-oqsUB7ZKQzBi4feLDgmWSZMLz8iEbt8JgdBaPfe8eyZ-mOy07SnR6Z1lYBo-llPKI=@protonmail.com>
Organization: still stuck in reorganization mode
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jari Ruusu <jariruusu@protonmail.com> wrote:

> loop-AES changes since previous release:
> - Worked around kernel interface changes on 5.14 kernels

thank you!
