Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121B53496E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhCYQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCYQfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:35:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726CAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=h2N5iTiUFJ30HZ922DZJoQ06P2tgZV8TgUIzLXMpsNo=; b=gESznxqrHPN0xxGejOYX743xQW
        YxhPNRjWpg29B6n6KDIwrG0iO//727RcronAP+ckAslO8wnk9RsHPw7/yJdtDUaEw8BXNl9jAJV56
        JQwD800182XMaEIBjYVqqb9k9Ma27zfuRj9FJ5usM5WIPmeHSMODB80zj2bL0+sXDUQIt0Q+BBM7L
        +kCT1DZM1aZ9Xjr7SD5E9I3KzBFFZXGhlqJz3VlPpV4LqVMof5Xx1S+RFVzKPLuSOQSE/9VbKIEOn
        uA7SeFRYP8RwKTCo3gr2qcdAyL8r8brBbLSyxgJzZXVBhgJx3mVQAfashSDr8FoLd+3mEGFX2U9+B
        dgLN96Ww==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPSww-001phl-Ls; Thu, 25 Mar 2021 16:35:10 +0000
Subject: Re: [PATCH V3] ALSA: pcm: Fix couple of typos
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        broonie@kernel.org, mirq-linux@rere.qmqm.pl, lars@metafoo.de,
        gustavoars@kernel.org, huawei@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210325090609.10372-1-unixbhaskar@gmail.com>
 <s5ho8f7mv5k.wl-tiwai@suse.de> <20210325095617.GB32566@debian>
 <s5hk0pvmrwp.wl-tiwai@suse.de> <20210325120717.GA9273@debian>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c611e36d-f11e-0c80-6dcb-2176c9ecd449@infradead.org>
Date:   Thu, 25 Mar 2021 09:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325120717.GA9273@debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 5:07 AM, Bhaskar Chowdhury wrote:
> On 11:47 Thu 25 Mar 2021, Takashi Iwai wrote:
>> On Thu, 25 Mar 2021 10:56:39 +0100,
>> Bhaskar Chowdhury wrote:
>>>
>>> On 10:37 Thu 25 Mar 2021, Takashi Iwai wrote:
>>> >On Thu, 25 Mar 2021 10:06:09 +0100,
>>> >Bhaskar Chowdhury wrote:
>>> >>
>>> >> s/unconditonally/unconditionally/
>>> >> s/succesful/successful/
>>> >>
>>> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> >> ---
>>> >>  Changes from V2:
>>> >>  Takashi pointed out that the patch was not applicable due to some unwanted
>>> >>  stuff get into it. Resending it with the new patch creation.
>>> >
>>> >Hrm, still not applicable.  Can you apply the patch from your own post
>>> >via git-am in your side?
>>> >
>>> Here is what I do for this specific case :
>>>
>>> ✔ ~/git-linux/linux-next [patch L|✔]
>>> 15:18 $ sed -i 's/unconditonally/unconditionally/' sound/core/pcm_native.c
>>> ✔ ~/git-linux/linux-next [patch L|✚ 1]
>>> 15:19 $ sed -i 's/succesful/successful/' sound/core/pcm_native.c
>>> ✔ ~/git-linux/linux-next [patch L|✚ 1]
>>> 15:19 $ git add .
>>> ✔ ~/git-linux/linux-next [patch L|●1]
>>> 15:19 $ git ci "Fix some patch error"
>>> [patch 88d5af187dbb] Fix some patch error
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> 15:21 $ git_fetch_single_file.sh sound/core/pcm_native.c
>>> Looks alright!✔ ~/git-linux/linux-next [patch L|●1]
>>> 15:21 $ git add .
>>> ✔ ~/git-linux/linux-next [patch L|●1]
>>> 15:21 $ git ci "Bring for patch"
>>> [patch 352e1ce8dacf] Bring for patch
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>> ✔ ~/git-linux/linux-next [patch L|✔]
>>> 15:22 $ git apply --verbose 0001-Made-patche-for-this.patch
>>> Checking patch sound/core/pcm_native.c...
>>> Applied patch sound/core/pcm_native.c cleanly.
>>
>> I meant to try to apply the patch from mail fetched from the ML, not
>> the patch you made from your git tree.
>>
>>
> 
> Hmmmmmm
> 
> bhaskar@debian_16:18:41_Thu Mar 25 :~> mutt
> Applying: ALSA: pcm: Fix couple of typos
> error: corrupt patch at line 29
> Patch failed at 0001 ALSA: pcm: Fix couple of typos
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> Press any key to continue...

I get:

patch: **** malformed patch at line 40: 2.30.1

which is this block:

@@ -1469,7 +1469,7 @@ EXPORT_SYMBOL(snd_pcm_stop);
  * After stopping, the state is changed to SETUP.
  * Unlike snd_pcm_stop(), this affects only the given stream.
  *
- * Return: Zero if succesful, or a negative error code.
+ * Return: Zero if successful, or a negative error code.
--
2.30.1


That means that this "diff" block should contain 7 lines of contextual
diff source code, but the trailing 2 lines are missing (after the "+"
line). I don't know how that happens.

~Randy

