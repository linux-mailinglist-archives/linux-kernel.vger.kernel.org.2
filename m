Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC74230E124
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhBCRfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:35:20 -0500
Received: from m32-153.88.com ([43.250.32.153]:17632 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231801AbhBCRfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:35:18 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2021 12:35:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=75LSi3Fn5V8im0bvlUT7vqNlmVFPcJ56EQGM5
        zWY/Cg=; b=dcqkm2qJvT+yJUH8fOmLp3XSlehqkjLRDvXOXeuZqWV/SHBZ/h9Im
        ifcXFBiVimKoCyufu4tO/iyKhvwLaB3jr2Jty3ROn2BrifN5GhoLGesUYg7pNPL5
        p053vZYJYZYuYhw1dFMRSXIsyTs5CfZkULDlYkh5bOM6DsPa1dr2/Q=
Received: from mipc (unknown [120.242.71.218])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAHjL5D3RpgbIkAAA--.1779S2;
        Thu, 04 Feb 2021 01:28:36 +0800 (CST)
Date:   Thu, 4 Feb 2021 01:28:35 +0800
From:   bobwxc <bobwxc@email.cn>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: syzbot reporting less duplicates
Message-ID: <20210203172834.GA3943@mipc>
References: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
 <20210203160543.GA19512@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210203160543.GA19512@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgAHjL5D3RpgbIkAAA--.1779S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5G7k0a2IF6FyUM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUuVWrJwAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
        6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr
        0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc_-PUUUUU
X-Originating-IP: [120.242.71.218]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 05:05:43PM +0100, Pavel Machek wrote:
> On Mon 2021-02-01 11:52:12, Dmitry Vyukov wrote:
> Could we please get common prefix (like syzbot: KASAN:....) so that
> the bulk of emails is easier to remove?
There are several bots testing on the kernel, maybe we should give a prefix 
format for all bot.
Also we can use mail-address to fliter email, but it's still a little 
inconvenient.

bobwxc

