Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852C641458F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhIVJyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234233AbhIVJx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:53:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ABFB61107;
        Wed, 22 Sep 2021 09:52:27 +0000 (UTC)
Date:   Wed, 22 Sep 2021 10:52:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Itaru Kitayama <itaru.kitayama@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Add pud_sect_supported()
Message-ID: <YUr82OmibtSG3Qsy@arm.com>
References: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
 <YUirurhvmBPCOsS+@arm.com>
 <127b2334-5c40-1b71-e510-ac837c3ac614@arm.com>
 <CANW9uyveSs-+DgGr87jYtruYcS7_FMxS=VD7mM4-G8NNcqBqNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANW9uyveSs-+DgGr87jYtruYcS7_FMxS=VD7mM4-G8NNcqBqNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:52:21PM +0900, Itaru Kitayama wrote:
> How did you test the 16K page size configurations? In QEMU? I wasn't
> aware of hardware that's capable 16KB page size.

Apple M1 (the easiest is to run Linux in a VM).

-- 
Catalin
