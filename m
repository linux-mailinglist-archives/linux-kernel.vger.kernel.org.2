Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A199F362ED6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhDQJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhDQJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:25:27 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E823C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Received:Date:From:To:Cc:
        Subject:Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=1cmxjMcfvrFVecoH9p5LC3mEGtFp
        rhW9cvmWSFdwapk=; b=OVJT4o9+QsMJ6IIkXq4w8FuiDjE6vIg0CAaAnkauThGN
        XlswS9OHBaObhWrxENNC6NOPCENGCw5TP+yx82zkGH4e/t6uYFND6Azg48GYBFwv
        zQ4SG8XIb7KVqQLzOjyWQdeQoAUIWBG8C98LSIuVgmtS8OTTCQpSZ4EBOwzyxeE=
Received: from wfg-e595 (unknown [36.27.85.226])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHzkpoqXpgYQLyAA--.4726S3;
        Sat, 17 Apr 2021 17:24:57 +0800 (CST)
Received: from wfg by wfg-e595 with local (Exim 4.93)
        (envelope-from <wfg@mail.ustc.edu.cn>)
        id 1lXK84-000Eqf-A3; Fri, 16 Apr 2021 16:47:08 +0800
Date:   Fri, 16 Apr 2021 16:47:08 +0800
From:   Wu Fengguang <wfg@mail.ustc.edu.cn>
To:     Hui Zhu <teawater@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hui Zhu <teawater@antfin.com>
Subject: Re: [PATCH for vm-scalability] usemem: Output a message after punch
 holes done
Message-ID: <20210416084708.GA56945@wfg-e595>
References: <20210414024436.30128-1-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210414024436.30128-1-teawater@gmail.com>
X-CM-TRANSID: LkAmygDHzkpoqXpgYQLyAA--.4726S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7k0a2IF6F4UM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2jI8I6cxK6x804I0_XF0_Aw1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr
        1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjxU2_HUDUUUU
X-CM-SenderInfo: xzijqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks!

