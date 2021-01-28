Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05A8307DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhA1SXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhA1SUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:20:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E04C0613ED;
        Thu, 28 Jan 2021 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3/eVDrOgGzWcTNcMv+Ud5/gsGdeOlwuJYul3Zh/W0is=; b=obNEnAK5172fzMAmMOvKftW+uT
        tgBeWfDHBa5niwyhQs0q9I31G0dB2+3JR+Ikwp0gdZtfg08x68hizv9xXyu2sdmwSDS+MkFEhd2i2
        pqS9UgGkKKiQWEgDzUqjwxG0lckEhLvCEualYSBJjKhkrVJ1AMUAs0EXNsE/chEVzrBXh1UyHrEM2
        O6QlgbuYNxFDJwT1nALipZA44aZvhw+gN50GZT0rKSe10vLwXU5STC3TCVvrlda2lP7CnuQcgpO33
        SyHzDSdz1O1UWRhtUh1cwx+Ggz79xYFQmk1Y22B96WIBkaAS/IOaSPuT9846zYCAfg/Zds/CXfnG0
        paHHtfyA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l5Bsl-008oGv-2n; Thu, 28 Jan 2021 18:19:04 +0000
Date:   Thu, 28 Jan 2021 18:19:03 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 01/20] ata: ahci_dm816: Ignore -Woverride-init
Message-ID: <20210128181903.GA2099675@infradead.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
 <20210128180239.548512-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128180239.548512-2-lee.jones@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 06:02:20PM +0000, Lee Jones wrote:
> Some ATA drivers use the SCSI host template, a series of interwoven
> macros, to aid with initialisation.  Some of these macros conflict,
> resulting in the over-writing of previously set values.

Please just disable this warning globally.  This is a sensible
patter and we should not sprinkle per-file options for something
that fundamental.
