Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603E3370AD6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEBJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhEBJAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 05:00:05 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45774C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Received:Date:From:To:Cc:
        Subject:Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=2kN5RoxGcYFPV4ASEK0rdUZHTVha
        OGBBJWT8cakBR0M=; b=KzUW/kwgBjN09NKz1tCUmP/jRic+PQiAHsfCUu3U53+4
        U76JXNkG3dQ4XJEKKP5ft6QhHBqz4BD0SMHoceZDakNotEN/J11xbpwczOrJWvpM
        Ba40/A2Q2iTz7hbbRgiquqi+AbkXhc1Y7hmsQ1PBFNmrX0pe+QNUTfOUOqwk/Qs=
Received: from wfg-e595 (unknown [39.187.199.74])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX3DTcaY5gdt94AA--.2063S3;
        Sun, 02 May 2021 16:59:10 +0800 (CST)
Received: from wfg by wfg-e595 with local (Exim 4.93)
        (envelope-from <wfg@mail.ustc.edu.cn>)
        id 1lclfN-000MEQ-HK; Sat, 01 May 2021 17:12:01 +0800
Date:   Sat, 1 May 2021 17:11:44 +0800
From:   Wu Fengguang <wfg@mail.ustc.edu.cn>
To:     Hui Zhu <teawater@antfin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH for vm-scalability] usemem: Update the usage of
 touch-alloc
Message-ID: <20210501091144.GA75412@wfg-e595>
References: <20210428092901.3103-1-teawater@antfin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210428092901.3103-1-teawater@antfin.com>
X-CM-TRANSID: LkAmygDX3DTcaY5gdt94AA--.2063S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7k0a2IF6F1UM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2jI8I6cxK6x804I0_Grv_XF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvj4Rg0eQDUUUU
X-CM-SenderInfo: xzijqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks!

On Wed, Apr 28, 2021 at 05:29:01PM +0800, Hui Zhu wrote:
>The touch-alloc was updated to write memory in commit
>3f9c6c227120db43873d1af20cea3f374eb99592.
>
>This commit updates the usage of touch-alloc.
>
>Signed-off-by: Hui Zhu <teawater@antfin.com>
>---
> usemem.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

