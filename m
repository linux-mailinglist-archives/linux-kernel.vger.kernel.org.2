Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957C8330545
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 01:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhCHAQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 19:16:32 -0500
Received: from mr85p00im-zteg06021601.me.com ([17.58.23.187]:38828 "EHLO
        mr85p00im-zteg06021601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231648AbhCHAQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:16:04 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Mar 2021 19:16:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1615162208;
        bh=X0pWED4lVmNp064KoP7G4XzPfwMx0M4Zvudh3k1W1YQ=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=x9RGv/DsZfbycOAT9j2FSU4hPW8frGR8Y2hDqwYRsj70u+RksF0uFQFmZP1HmOh4N
         9MIpUKUJnnlHL5k+syS5LkmCclFRaWRlHywFjIjwH/ZvBA3caGDRRpOkZETGjFMjFh
         mr1q9WOlMKheLqiP/0nmMeuxdesDUh2Fw3NI5RIozxnZ5PkNJG6IBQ6EZU5gKWY8f+
         zygTkOPU+2cya2g7SqX+UPlBcDS2fNZ1n0DcfC04o5VYRdwMSmN9KY5qzd+BppQbQF
         ceytL21Cw2OzKaVTNRUcRbXE7M/N4JH69XiLftBUnwMdjC44QlB2xT17mAyegJVxI+
         EOhHfSsZUm5pQ==
Received: from tbodt-pro.attlocal.net (99-130-36-163.lightspeed.frokca.sbcglobal.net [99.130.36.163])
        by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id 016A8400584;
        Mon,  8 Mar 2021 00:10:07 +0000 (UTC)
From:   Theodore Dubois <tblodt@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: What clockevents are needed to boot properly?
Message-Id: <02EC6936-C879-4681-AC37-76DFAA7DA3AC@icloud.com>
Date:   Sun, 7 Mar 2021 16:10:07 -0800
Cc:     tglx@linutronix.de
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_17:2021-03-03,2021-03-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=657 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103070135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm playing around with a new kernel arch and running into problems with =
properly configuring the clockevents, especially with SMP. Without SMP =
you can easily set up a clockevents masked to cpu 0, and this seems to =
work fine. But on SMP this fails silently: high-res timers created on =
cpu !=3D 0 never fire.

The obvious next thing to try would be to set the mask of the =
clockevents to cpu_possible_mask, but this silently fails as well: the =
clockevents just doesn't get used at all. There seem to be a lot of =
drivers in the tree that do this, I'm not sure why it works for those.

Do you have to register a new clockevents for each CPU? I can't find a =
lot of information on this.

~Theodore

