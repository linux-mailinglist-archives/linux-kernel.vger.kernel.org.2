Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1040AF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhINNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:43:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57405 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhINNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:43:19 -0400
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18EDfjtP001530;
        Tue, 14 Sep 2021 22:41:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Tue, 14 Sep 2021 22:41:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18EDfj5F001479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Sep 2021 22:41:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: linux: build faulure: error: "__has_attribute" is not defined
Message-ID: <c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp>
Date:   Tue, 14 Sep 2021 22:41:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

With gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3) on d0ee23f9d78be553 ("tools:
compiler-gcc.h: Guard error attribute use with __has_attribute"), I get

  CC      /usr/src/linux/tools/objtool/exec-cmd.o
In file included from /usr/src/linux/tools/include/linux/compiler_types.h:36:0,
                 from /usr/src/linux/tools/include/linux/compiler.h:5,
                 from exec-cmd.c:2:
/usr/src/linux/tools/include/linux/compiler-gcc.h:19:5: error: "__has_attribute" is not defined [-Werror=undef]
 #if __has_attribute(__error__)
     ^
/usr/src/linux/tools/include/linux/compiler-gcc.h:19:20: error: missing binary operator before token "("
 #if __has_attribute(__error__)
                    ^
cc1: all warnings being treated as errors
make[5]: *** [/usr/src/linux/tools/objtool/exec-cmd.o] Error 1
make[4]: *** [/usr/src/linux/tools/objtool/libsubcmd-in.o] Error 2
make[3]: *** [/usr/src/linux/tools/objtool/libsubcmd.a] Error 2
make[2]: *** [objtool] Error 2
make[1]: *** [tools/objtool] Error 2
make: *** [__sub-make] Error 2


On 2021/09/14 15:22, Stephen Rothwell wrote:
> This is known and being addressed.

Can you tell me the commit ?
