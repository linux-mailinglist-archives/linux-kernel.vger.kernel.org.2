Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBB3B53EA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhF0Oy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:54:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:54617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhF0Oyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624805547;
        bh=IS1rUEldxwqNfYmXj7AquAVXE858I9p13sv6uyYX+nM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=PrtqNp7DoBlmEnLUf6K5UadxjGM7q/F1oxCtuDO79nu3RWTSU2fnZ2XCt6tfJqlB1
         v0sDZCfUdpDvSMP0/M7RFk5uO7cJPUkz/aU7OD3x3REighzM9QyEp1KbJXoD+9pwi8
         /6O9m1HkhZa2cufbCJnw2M8WqWOJYoCHCOG554y0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.131] ([79.242.183.139]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1lzAq51w0c-001g24; Sun, 27
 Jun 2021 16:52:27 +0200
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
From:   Armin Wolf <W_Armin@gmx.de>
Subject: [BUG] checkpatch ALLOC_SIZEOF_STRUCT ignoring devm_* functions
Message-ID: <fc9c7000-19f7-33df-b645-e2664978521e@gmx.de>
Date:   Sun, 27 Jun 2021 16:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:SHcwYr9atYwppixPQwyOI7LrO80Kan+GbjeWfcH+UhyKQfzrA7T
 YB4UYhS5BcxtOl6gx/fi6/m4NTuPKkI2kWRTg/LJLo97o6G7GVgODAVNiMTWJL7/t2vFlkQ
 suCrqIkAO7W7VsAObjGGpVh26dCxpFIfJSYBWW+waLynX6Ry51I3WLYJgd/PlYgzywZKypA
 YT7yqY5d/cnZLX2AQ0hQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nWhTxqkRJVQ=:tM7r/SrnVuVYAxQ1KFB0BZ
 Mr45LnbBxYJ6qQN/I/YEFx8NWDhfea8mpikNQVfDZ0rpsIoMbf7Tm2LT0amZMvT2DZMsdPhkU
 I41w+BkyOa8Fmhn2QcIRHQ5V43CSiiiO53B9sp4fFF3+OjOwkpucLWUPFLvrOxsV30lNdEqIV
 /F0uVBP6n9x7HKWiFwljq9khlV8t2A7Ctmwl3i4xfyetD4GnRgU9z3/UnaCvlVqcud2IhkSlN
 zqS5QQaO+ZXxzATgDHcMGQwtUWL5sxcoPP8eP+rPQsfYTQM/akpBRMRkSXT2CTgIk3YhxSzLT
 qmJ9QK8HMLvGsy9Ney5nzeylzQkAkbM8aUiavMEzwspBwsz2+4hC0r7OIsb8Vvskjcowo2030
 F2YQEONmoknsBi20ojEKXXTf7VzVVxkwZSx91DywSlyRIDIY8ZdgAW4V8+sI6LaaFvVf/tf5h
 Y3588r+7qlWbdfM9hG4J+0DSF75l68CBNjWiGdtMwUeetvPAsIlTbDA62zfMyfxN6u+9Pjdaa
 McXuwih+/Xl6yFbWwU3Bg++nGymLbhQAkDEqm8g0eHX8BHWaYLIDd82WJVRNPp5sRqc8A+m+G
 PwUFZfF21VZ7dLh3W5qH2RdkpS46upuEDP1Oz0HT3f6dqkHOwmYzNP4SDtekAkomgwsPIw+L8
 WdMUFhorOxnd40K04lCljKH5DvjInpSjDY+lZmB0Rya3ghWgRa04XXmMq/aS/VddGJU1DD0MY
 uKt2nYViKNZfic3hAj3u7Xyb0cB+i2FwXvsA+eXMB/4AsFw9H5QT5YUi+R8+HRkuC87IXVW/g
 LqGI48ldx3DBwpp58OaCW+F77qvZLlbCLDQzKeA9uiR9Uumt6L7SWtG2MxF5JfHyiQONzUTeV
 OQs3HdXLw6XlW2DSC24BJvUO9K3ywNnPcOaVI9VtHl5jLWmCMlZHyN9cdmEkl+Z3iyckNWdgy
 9u35JysOYaOsjuBqp5Uma0l+5vC86gGT+FpP57zK9mYhgh20M9ZEAnDoIpt33T50ZWoNtNUOm
 uETQPY+mHV0tV6wF2S72kpwGIK8IPuOGJfU9JiApEdY3tk+/O9qCySTV+UfOkbxMuwRQ6y/Ow
 4pxLbwzjdL3dPvV5zKPOOdW+lNBTDuzsbbO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a source file containing something like:

data =3D devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERNEL=
);

checkpatch is not complaining.
But when doing the same without devres:

data =3D kzalloc(sizeof(struct dell_smm_data), GFP_KERNEL);

checkpatch complains "Prefer kzalloc(sizeof(*data)...) over
kzalloc(sizeof(struct dell_smm_data)...)".
I think checkpatch ignoring the devm_* function is not intended.
