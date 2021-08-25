Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0D3F6F88
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhHYGeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:34:04 -0400
Received: from verein.lst.de ([213.95.11.211]:54933 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238964AbhHYGeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:34:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90E706736F; Wed, 25 Aug 2021 08:33:15 +0200 (CEST)
Date:   Wed, 25 Aug 2021 08:33:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 1/3] fs/ntfs3: Restyle comment block in
 ni_parse_reparse()
Message-ID: <20210825063315.GA28148@lst.de>
References: <20210824183708.1008538-1-kari.argillander@gmail.com> <20210824183708.1008538-2-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824183708.1008538-2-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 09:37:06PM +0300, Kari Argillander wrote:
> First of this fix one none utf8 char in this comment block. Maybe
> this happened because error in filesystem ;)
> 
> Also this block was hard to read because long lines so make it max 80
> long. And while we doing this stuff make little better grammer.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
