Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062683B1B66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhFWNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:45:28 -0400
Received: from verein.lst.de ([213.95.11.211]:50960 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhFWNp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:45:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1597A67373; Wed, 23 Jun 2021 15:43:08 +0200 (CEST)
Date:   Wed, 23 Jun 2021 15:43:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: remoteproc DMA API abuse status
Message-ID: <20210623134307.GA29505@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi remoteproc maintainers,

did you make any progress to get remoteproc out of creating fake
devices that fake their dma ops status and the abuse of
dma_declare_coherent_memory in removeproc_virtio?  I remember we had
a discussion on this a long time ago, and there was an unfinished
patchset to change the memory pool handling.  What happened to all that?
