Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB263AB5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhFQObD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:31:03 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:52060 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhFQObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623940134; bh=LAL9LY0UrYbyJUihXjQ953KjGs5SzfoD7ucw0Wjvqfo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=u3u0AGjv8aG5UQitLG9FCZDUidKQoIPNNuYPhCuay4SHDSieSJIIAc3/CjR4r4L3b
         X1i7TmmOFr9YEiF4wBat5CWAoDOSST8AyeFoakoMwyALYIe3aI2phKEuB9ATe+Ev7P
         GZ+SPGMsTYAXAjmDxTzKGxox3aYHAK+qWKaOML1ReXjVF01anlOuY5dQaaEUlMum/s
         Lr68lZW4U16Frf/AZYSJq/uze28J53OrPXbCbZkMNmvrNpWadBzWTJzpwrmKir8LU0
         cjpk4y1MYkngL9McJGQ1g2LPkY6KLBE+JvK7IpJYg26i2lo5LB/68xvHo6Sr9L7vOi
         YICXO0LDK4Icg==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 21C2DB0039B;
        Thu, 17 Jun 2021 14:28:50 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@me.com>
Subject: [PATCH 0/3] some improvements for lockdep
Date:   Thu, 17 Jun 2021 22:28:25 +0800
Message-Id: <20210617142828.346111-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_13:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=544 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106170092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlikely the checks of return values of graph walk will improve the
performance to some degree, patch 1 and patch 2 are for this.

The patch 3 will print a warning after counting lock deps when hitting
bfs errors.

Xiongwei Song (3):
  locking/lockdep: unlikely bfs_error function
  locking/lockdep: unlikely conditons about BFS_RMATCH
  locking/lockdep: print possible warning after counting deps

 kernel/locking/lockdep.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.30.2

