Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF234F3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhC3Vxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhC3Vwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:52:54 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:52:54 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0513CC01D; Tue, 30 Mar 2021 23:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617141173; bh=6VmtjFhYhwPr5OyiXU90y4E8e677PMijp5uhdzB0pWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueF4T32DmiEbJrb1St6Hyv/1ZYpWjbY74k2rI9CVRJIQX2WrwqbLrJMqGydwHQsV9
         bxTy5eFy/k7N+cEPbEtxAvorVa89Gel6dDYt01XKNKx5nMhbFNGoIkAIp5h5ep8fx8
         rdyhUe6xqTemLwxaa9GDQ5gKasl5ZK6VnmmIdaVqEUrUWDN+a82Dm44PL9a1ZLtG1U
         bSzwRx5bDkfPCG3yL/XD1i+Oz0jdj0v3Q5WRXjEPHJbQzowoSEkfarWgWQAhy2YCTU
         4usTDC8rI9q2Qfx3mKnttflj+FVHF8UIxqArjvYUnsCdV+EkI/4ldSLxFiK7DBsa13
         MBSXyVuH1Gd5w==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 98886C01A;
        Tue, 30 Mar 2021 23:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617141172; bh=6VmtjFhYhwPr5OyiXU90y4E8e677PMijp5uhdzB0pWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2xtYcmClS86PCDnYJVvmrwr8Jy68IqK35UM+mpQC8fMeet4JA8EtSlu4QjAquSV6
         VQ27moR3cDbdrdbCb1ooZfpL+6MAT7Vu1Q9LKo7UIuW8Xr6zsvrIOyQ/3v+rOog2GR
         t33QCnJ47jg52pFG5QhId2CBjMPr7R5TFbUxw3g0zTwq4c3i6CXxwHi8sypAyh+t/6
         zREcizgreMGvE49K9MvadwYkar91inQMbnmUjzfqHr4TH86Xe0YsDKdbnELBgn5DuF
         pmRWy5zz2s31C1ysKg6KE+RhNKNc1Upc445HndKwlu4S2UibEj60AfjP77UF0xMUV6
         IoHMNwieZ3CPw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 44fde785;
        Tue, 30 Mar 2021 21:52:48 +0000 (UTC)
Date:   Wed, 31 Mar 2021 06:52:33 +0900
From:   asmadeus@codewreck.org
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH -next] fs: 9p: fix wrong pointer passed to IS_ERR() and
 PTR_ERR()
Message-ID: <YGOdoWkd3t0pVyfR@codewreck.org>
References: <20210330130632.1054357-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330130632.1054357-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Yingliang wrote on Tue, Mar 30, 2021 at 09:06:32PM +0800:
> IS_ERR() and PTR_ERR() use wrong pointer, it should be
> writeback_fid, fix it.

Right.

Good catch, thanks
-- 
Dominique
