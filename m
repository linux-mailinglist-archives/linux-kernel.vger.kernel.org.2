Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA7337081
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhCKKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:51:45 -0500
Received: from verein.lst.de ([213.95.11.211]:40378 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbhCKKvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:51:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFDD868BEB; Thu, 11 Mar 2021 11:51:22 +0100 (CET)
Date:   Thu, 11 Mar 2021 11:51:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme/rdma: Fix a use after free in
 nvmet_rdma_write_data_done
Message-ID: <20210311105122.GB16485@lst.de>
References: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.12.
