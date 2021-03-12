Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F7339361
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhCLQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:28:18 -0500
Received: from verein.lst.de ([213.95.11.211]:46223 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232603AbhCLQ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:27:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0776B68B02; Fri, 12 Mar 2021 17:27:42 +0100 (CET)
Date:   Fri, 12 Mar 2021 17:27:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bas Vermeulen <bvermeul@blackstar.xs4all.nl>,
        Christoph Hellwig <hch@lst.de>,
        Brian Macy <bmacy@sunshinecomputing.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 23/30] scsi: initio: Remove unused variable 'prev'
Message-ID: <20210312162741.GA11341@lst.de>
References: <20210312094738.2207817-1-lee.jones@linaro.org> <20210312094738.2207817-24-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312094738.2207817-24-lee.jones@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
