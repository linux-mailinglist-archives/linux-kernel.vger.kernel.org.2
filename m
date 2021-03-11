Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6E337080
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhCKKvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:51:44 -0500
Received: from verein.lst.de ([213.95.11.211]:40373 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbhCKKvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:51:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9997168B05; Thu, 11 Mar 2021 11:51:10 +0100 (CET)
Date:   Thu, 11 Mar 2021 11:51:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de
Subject: Re: [RESEND][PATCH] nvme-pci: add the DISABLE_WRITE_ZEROES quirk
 for a Samsung PM1725a
Message-ID: <20210311105110.GA16485@lst.de>
References: <20210310120641.1633-1-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310120641.1633-1-dmtrmonakhov@yandex-team.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.12.
