Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071E4441E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhKAQeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:34:36 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:49822 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhKAQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:34:28 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhaDn-00HNvE-GK; Mon, 01 Nov 2021 16:31:43 +0000
Date:   Mon, 1 Nov 2021 16:31:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gou Hao <gouhao@uniontech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiaofenfang@uniontech.com
Subject: Re: [PATCH] fs: remove fget_many and fput_many interface
Message-ID: <YYAWb5fg5uQQN5H9@zeniv-ca.linux.org.uk>
References: <20211101051931.21544-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101051931.21544-1-gouhao@uniontech.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 01:19:31PM +0800, Gou Hao wrote:
> From: gouhao <gouhao@uniontech.com>
> 
> These two interface were added in 091141a42 commit,
> but now there is no place to call them.

Gladly.  I'd add a reference to the commit that had removed the need
of that wart (62906e89e63b "io_uring: remove file batch-get optimisation")
to the commit message, but yes, that's something I'm very happy to apply.
