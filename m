Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9987344A836
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbhKIIRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:17:34 -0500
Received: from verein.lst.de ([213.95.11.211]:49051 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235389AbhKIIRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:17:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D6F167373; Tue,  9 Nov 2021 09:14:46 +0100 (CET)
Date:   Tue, 9 Nov 2021 09:14:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Huaisheng Ye <huaisheng.ye@intel.com>
Cc:     dan.j.williams@intel.com, hch@lst.de, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] add ro state control function for nvdimm drivers
Message-ID: <20211109081446.GE28785@lst.de>
References: <20211027120937.1163744-1-huaisheng.ye@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027120937.1163744-1-huaisheng.ye@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
