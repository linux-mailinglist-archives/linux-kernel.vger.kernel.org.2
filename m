Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9DE3D96D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhG1UhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhG1UhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:37:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8CCC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a2nnb4Mp8S24aWxbtXWtMrIAvjYYvj79i33PXyGGISc=; b=RQfrrtvn0KH4CtgS77upac10DA
        rj6uwLcmyLT499KCXtZfze5huDX0qohtpuTeXaotOtHfojuGzGcQcsdnHPxHfxU+cltqOfx4gUqWW
        HFcbuTyR4cD4P2xyRzxFTQhWzJrIZ/8bEY9pXzXZRI8NbdwWcdN00pVtWp+o/CQoeKVggy8QuB12Y
        OeaJxdDfncdmbS6zqUrolU9e/pWVViYUBwrym+erSGzU/2kznwpv7d7+QHt8j4eZ86uAskMMfqiAp
        uMAFG2Gf9Mcr8SK6ONunwW5of3FUUdfHQbc2jfAVtWidqTSn1YtAYtGQDxhwbPZAleZgg3C4Z4ZuI
        P7NI2VwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8qIf-002K4c-4o; Wed, 28 Jul 2021 20:37:09 +0000
Date:   Wed, 28 Jul 2021 13:37:09 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, skhan@linuxfoundation.org,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v8 0/2] firmware_loader: fix uaf in
 firmware_fallback_sysfs
Message-ID: <YQG/9RPgETxF08Vz@bombadil.infradead.org>
References: <20210728085107.4141-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728085107.4141-1-mail@anirudhrb.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:21:05PM +0530, Anirudh Rayabharam wrote:
> This series fixes the use after free in firmware_fallback_sysfs reported by
> syzbot at: 
> https://syzkaller.appspot.com/bug?extid=de271708674e2093097b

Greg,

With Shua's review ammeded, this series is ready to be queued up, finally.

Anirudh, thanks for following up on all these iterations!

  Luis
