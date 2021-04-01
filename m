Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5819635184D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhDARpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234619AbhDARi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8ECE61369;
        Thu,  1 Apr 2021 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617289958;
        bh=RNONe9oly32stda/UPL/dgZMQApeW+L7RNnujmFJcuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3sUvXlg4ZqtCTIrHOUA8y3xuUn+MQhZZ/iacVYOEMlRa6rl7O8OjXwng5BzsEE1O
         DN7NMgJTu4MXgwkGGMjfoSVKAt+2TNgoLLz1nEYyUSpJIn3XczlOsBRwYn0m32CLJ1
         EA6qD87ZqvT4r52Es8cf8aCmZvS50n/Y8HxZ2YzdqvPs16LWe2ggJWKhRq4xZri2b3
         0rrwAz52tbLFwhKxYz0fLBa2CsFagmR30cxxiQVJcWfU/zfBTNhZ1uxg6YFK3z72xq
         wQ4tmHiHuJ48CNEgkU/T9HeQ/gdKXcd2zA6eCNfBI9jC6qwgc8TxZ/76WnKe1M4zYN
         Wr1h1qt0fLL6A==
Date:   Fri, 2 Apr 2021 00:12:34 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 2/3] nvme: Remove superflues else in
 nvme_ctrl_loss_tmo_store
Message-ID: <20210401151234.GB29196@redsun51.ssa.fujisawa.hgst.com>
References: <20210401095412.84254-1-dwagner@suse.de>
 <20210401095412.84254-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401095412.84254-3-dwagner@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the subject, s/superflues/superfluous
