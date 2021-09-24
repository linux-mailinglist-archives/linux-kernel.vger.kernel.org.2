Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC202417913
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344019AbhIXQso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:48:44 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:44182 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343679AbhIXQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:48:44 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id BA06E82358;
        Fri, 24 Sep 2021 19:47:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632502029;
        bh=2n8BTFE/L2zXVG5WZY/yvbxWYftQJlmF6IzeiYUFnM0=;
        h=Date:To:CC:From:Subject;
        b=dIun0QLUKw15SMplMDLP2fD0J5RFJdQqkpUx+9njxtCOEbaRJKeN6QATu3LkOFQFe
         E5hizH1HrDuGYTdWL0dc8AMcWqatRl8srru7pUiMLMCOxPOvuAHN89CbYsE/BcDU3j
         eBUBqPqREj6n+Se7MwLdHpjdkUe5lrTUzoQoxEbo=
Received: from [192.168.211.101] (192.168.211.101) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 24 Sep 2021 19:47:09 +0300
Message-ID: <89481e37-6723-6dd5-3549-85d1aa9fccbe@paragon-software.com>
Date:   Fri, 24 Sep 2021 19:47:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <sfr@canb.auug.org.au>, <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Question about ntfs3 git pull request
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.101]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Stephen, Linus!

I have a question about next git pull request.

After first ntfs3 pull request [1] was accepted
there are some new commits, that I want to send for rc5 probably
(need more tests + some time in linux-next).

I've noticed, that I missed step
"If your upstream-bound branch has emptied entirely into the mainline
during the merge window, you can pull it forward with a command like"
from Kernel Maintainer Handbook [2].

Right now my github repo still based on 5.14-rc7.
Do I need to update it with git merge up to 5.15-rcX?
Or will it be ok to send git pull request as is and
back merge master only when 5.15 will release?


[1]: https://lore.kernel.org/linux-fsdevel/aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com/T/#u
[2]: https://www.kernel.org/doc/html/latest/maintainer/rebasing-and-merging.html#finally
