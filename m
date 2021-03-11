Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44832337109
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhCKLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:17:56 -0500
Received: from verein.lst.de ([213.95.11.211]:40485 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhCKLRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:17:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 34C6E68B05; Thu, 11 Mar 2021 12:17:22 +0100 (CET)
Date:   Thu, 11 Mar 2021 12:17:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org, chao@kernel.org,
        Daiyue Zhang <zhangdaiyue1@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Yi Chen <chenyi77@huawei.com>,
        Ge Qiu <qiuge@huawei.com>
Subject: Re: [PATCH] configfs: Fix use-after-free issue in
 __configfs_open_file
Message-ID: <20210311111721.GA17148@lst.de>
References: <20210301061053.105377-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301061053.105377-1-yuchao0@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied.
