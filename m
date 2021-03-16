Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D5633D335
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbhCPLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237279AbhCPLh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:37:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A2564FED;
        Tue, 16 Mar 2021 11:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615894673;
        bh=TeQWkqwiwIRwCkj1q2ZFITQqXwzqYFUhoclW7z6bcTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLucAyRdYU32ZXI9yOPzcwsB2Uyhk+MMtLZKt6Y6u8SrUZiUPwY25BcgHUGrxNy8m
         COun5XggrVh5HQqjcDfGO2Po3jX0w5PKdHMwdklaKleO1gKpWyPU0TtpOhInhOgeKG
         rEB+pz8QrZVtSb8S/gcHELDQSkhy/TG5sdqOKv0A=
Date:   Tue, 16 Mar 2021 12:37:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Peng <penghaob@uniontech.com>
Cc:     ross.schm.dev@gmail.com, izabela.bakollari@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: remove extra lines in rtl819x_BAProc.c
Message-ID: <YFCYjjIMtQAuCHZp@kroah.com>
References: <20210315110418.25117-1-penghaob@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315110418.25117-1-penghaob@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:04:18PM +0800, Hao Peng wrote:
> Remove extra lines in rtl819x_BAProc.c.
> 
> Signed-off-by: Hao Peng <penghaob@uniontech.com>

Same issue here, please fix up the changelog text.
