Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0943FF03
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJ2PHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2PHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:07:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62252C061570;
        Fri, 29 Oct 2021 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=SiX9UHoKQRXFz7uP18kxGHUXOhLYqA4eqNBdQkR4TXE=; b=VdHWj0+nTUKPpKWf81O53GmJ4F
        Y7kKTY7MJ2Zcuu77lNqX67xwl83XeEbX0np9vqqR44i+AQylcpAnM1v4qlYv9h29Kya5GKCN2ybE3
        W+t52oiDWqFAjYFnW+1N7gFe8c18KfnHZFF2Tn1ky0WyEOyvINHO40OgAXuCfudialdyEi5OpoaKo
        B/pw1X7LSoGoe6cqWosHKEVzjEwx5OxDuOlTzkAIRMCNRp0Dqu779rbzrQ1EE/5/d+GI/7ilbja7c
        C4g1+CtTsxilGDlvOj/9Etq7zQgegEtyQsoLdShVbdRgvac18HmoqGjHShEnXTzy9TdCj3Sno6JbZ
        M0Pz7m3Q==;
Received: from [2602:306:c5a2:a380:b27b:25ff:fe2c:51a8]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgTRS-00D6jk-Vo; Fri, 29 Oct 2021 15:05:15 +0000
Subject: Re: [PATCH 10/13] ps3disk: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        jim@jtan.com, minchan@kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-11-mcgrof@kernel.org>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <01e79b30-8ac0-c384-d57d-7c79e7f244c2@infradead.org>
Date:   Fri, 29 Oct 2021 08:05:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015235219.2191207-11-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 10/15/21 4:52 PM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

I tested your 20211011-for-axboe-add-disk-error-handling branch
on PS3 and the ps3disk changes seem to be working OK.

Tested-by: Geoff Levand <geoff@infradead.org>
