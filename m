Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7721D3F441B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 06:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhHWEXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 00:23:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:35097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhHWEXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 00:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629692523;
        bh=TB0LjgnrwKKFd7ubtBDLzKvgqXa8fYT5WytKd2r03uI=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=Zn2VC/p7fpjzg37bYZMMsTkj8Vx7Hzz5tik/3QVnya+vZOV2gLDtbnXDF1odVyfaf
         2j57ZUDb5njy1OMVHx2iURPsEPOd45IWlx+CyeHSiti0L6BrK/1r9MXQGI5vLmfMEp
         eH2N+PGUELSUhm/xzo+rMfVs32TPxf380Ub/Tqf8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.232]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1mg2de01cX-00ObDK; Mon, 23
 Aug 2021 06:22:03 +0200
Message-ID: <b9b55cad5b7ca120ebec2acbbbd0a7fc1a986ec7.camel@gmx.de>
Subject: Re: [PATCH,RESEND] softirq: Introduce SOFTIRQ_FORCED_THREADING
From:   Mike Galbraith <efault@gmx.de>
To:     Wang Qing <wangqing@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Aug 2021 06:22:01 +0200
In-Reply-To: <1629689583-25324-1-git-send-email-wangqing@vivo.com>
References: <1629689583-25324-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mn8HQDpm9HxJtN0xT3j/1TTdoRpTra4Tz9py0vPeo5zZ0260Tyq
 nfbhYlYAbW91qCxxb6A6zwOUQi2Ni7n1lytiSyjx0nAH0JXlNFVyWyil7FSgsjbGTg0UtYX
 bRQVp0SMxUoRaYBE8Qq/tWUi2dfrUgHdmoE/mq6toutEndYDVfrMrtxVn/YoWlXvzX19j6r
 UFOYIqVCEzbmwMl9t20Gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c1Eld/+yuE4=:O/ySG2NYsalDDdO779+Nj+
 I8dZkFXP0WsOdkYMGa3MkghPJCY8xppZ1LrZkwUtLiVCxkS6WZ9SqOloFVOB46LF92qXBfnfk
 lwP7LYi3OnKzAg20VizWJyVsuXsCCandsiL/u82TGahxK26yM/6TQdW5PDE/F+9ZuNhoU8QXt
 EO52O7fprBogi5pdQ9gm1dxSFvRcY+5FrV9M5aWsM+DUGzERYHqMFj8zcxodJbww4/8NEJZuP
 RNO2A4l/6NNLktrYWunFuzva4dlJXracNqU+yT35IsCMKXbGwc9HbNYe8K3n8vgp5nQymd4NH
 JG5+9N9IQP4DVs5zl7xKgiMpMNZouAKsQYhY/fBy7UB8yNnZoNV7Fl507qtC99+dRGCUrhnl0
 UR50i8PfAYkIGDtuIWR25fSsa+OzgwQOTZJMbeEcsOtTak/M5B7NIFCDo8yuFLSeX9JoPCiWx
 gm05xRv1FYS7o+ROzozUYWhdfhb8YbQCIwm6awT/oQn0qGZEmDmMOOTfJa+rvBS+5oM0tZKWM
 v/mTpihl1MBx5iIhuuxB5OxsA+/CrbJ5mw0XxcJ/OztW+d8cqMvoyEwhZulCyQv8Msred2D64
 9zJu9fhmlyLQlZ1jHwJfwMqlnmS8Vu3pCKW3jEd2OxQY6m3gSe4+u4HrZblartFzxnh9rSSg1
 4iMF/uc22dH0ECaV5Q5Wa9xswVqOvDbpnOBhCPGephM6yLXhr12gtZNmEWletHaKe/zKWg1fP
 4K9wO6zYZsa8TSqmMp/NgOYCP24eFphlfREa1d+EENlkpbD2xlB4pq9RfiTxa89sP9CLrJBBi
 T6opRt0jxtdy2wV4Wu4uF1hGyw+8hlj/ufDj85np6vPRpgaE3DM//onieW7Yot2tNxgHkBDzu
 9ymSVcSBSynd2MSMulMHMKgwhjT/x7WcT/ZgQBuRJLf105GSpFtSZVnxYW4xAJrYeqF1yGpmo
 97jMr1/9Z/0gXVuTk1BE2cCWZFSBeZs1sMLmIaKVGJWJTYbD5HPrbMItpdPBmScWxNPr+Jpo4
 poK+hUsNvH0twiMou1jEIvdml0+AmUiCnUBa42ask8Qqh5NyYjJ7iYc3r5fD58oj9svFW2/On
 9vC26kdZNk9iN/dNVDZLuNpgnkFZTGdGInW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-23 at 11:33 +0800, Wang Qing wrote:
> At present, whether the softirq is executed when the interrupt exits
> is controlled by IRQ_FORCED_THREADING. This is unreasonable. It should
> be split and allowed to take effect separately.

Decades long practice suddenly became "unreasonable"?  I think not. =C2=A0

Trying to carve out bits and pieces of RT to merge immediately isn't
likely to make the ongoing merge effort go anyfaster or smoother.

	Just my $.02,

	-Mike


