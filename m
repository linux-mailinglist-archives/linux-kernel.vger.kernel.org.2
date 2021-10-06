Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A72424043
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhJFOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJFOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:40:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79760C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:39:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so9568266wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrYIZor5JpptgMqrcfH7/vZxkBcffIVdWpCqOa60u0I=;
        b=olEQKj++f4P84owZIlA+qxQUwmy7yx1vI3x3fCx0m8MJfeyp3D6Qx+vTrhwzxC4Zd0
         Np5NzSJXNz/zeQ/VN0Zso4F2weEx1oPNyQx57qnD2o12iwPjiEvODEvBtPWlVHTXOPVO
         XJurTrTsvHuaIaFe3xt0Xn5VyNknWfU3pHZrrMSrCzAVtPCFIEgvI3wjDPb9yRuzQyTh
         3gaNDYfLYUjzaHBzdms/+kqCGRP3NlYF+M0/oG3QPfGMMSPiJM6sHXctRKzKhTpT+x0X
         1BRe5IjFwPTXMlqQt7ZO4tCJM74f00YRHc2F4e/8R7tI+yPzBfq4VzMEn3MxxwK06HPS
         zoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrYIZor5JpptgMqrcfH7/vZxkBcffIVdWpCqOa60u0I=;
        b=3bTcLletaAVGdZysNc6EYtu+0h53ahWwXDNY3F7jGpCvxc7rMwo4hyG2kxRUS3u/wH
         CWxBfZS9AoXeyOBNAQdUwkyrWJkY19yMoxYeD/oVl9zvA4Muz5i2Ao2k3b4rHITe/I/3
         oFghKO0yJUK+sWkuozA49LwM74YmNF6mQSaUDgXSqki9Nqo8FehyfTV5BWdBYiPM7sY6
         qBUlBfYY+oq4fVu4KaK+rX2bIDZlodQ+FpNOcWKXmdfAnsT59R9TYU8WRy7zngkRtKHk
         NaKtVvoDaictjkfwGvipTRYhlho5Sf3MwfZdEXyLKJtP9eLbIET2265JB21EcKk187MI
         +QHg==
X-Gm-Message-State: AOAM530bCuLhcPcvIfH3dbQLj3QX1vhAKaYEYzkCt0Kfdtx33DBcqwnK
        Au2lWtxk6zPufHlZsqS+bCY=
X-Google-Smtp-Source: ABdhPJyUIuNNlKjnL/lDDT7G0Dj4894e1H6/JtUsUL5EACYzHOaQ185WYK8frcmThsalXX/CaN3kCg==
X-Received: by 2002:a5d:453b:: with SMTP id j27mr29724818wra.324.1633531145069;
        Wed, 06 Oct 2021 07:39:05 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id i3sm5419538wrn.34.2021.10.06.07.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:39:04 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in rtrs/rnbd
Date:   Wed,  6 Oct 2021 16:39:00 +0200
Message-Id: <20211006143902.129864-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated worlds:
- "as as the"
- "the the name"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-rnbd-client | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-client | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
index 0b5997ab3365..e6cdc851952c 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-client
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -128,6 +128,6 @@ Description:	For each device mapped on the client a new symbolic link is created
 		The <device_id> of each device is created as follows:
 
 		- If the 'device_path' provided during mapping contains slashes ("/"),
-		  they are replaced by exclamation mark ("!") and used as as the
+		  they are replaced by exclamation mark ("!") and used as the
 		  <device_id>. Otherwise, the <device_id> will be the same as the
 		  "device_path" provided.
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
index 49a4157c7bf1..fecc59d1b96f 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-client
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -78,7 +78,7 @@ What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
index 3b6d5b067df0..b08601d80409 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-server
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -24,7 +24,7 @@ What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
-- 
2.25.1

