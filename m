Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD134C2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhC2FQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhC2FQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A51C061574;
        Sun, 28 Mar 2021 22:16:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f12so8576925qtq.4;
        Sun, 28 Mar 2021 22:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3sGhycMBJPPvv45Cb1ionNhosmVwz+OP/TrPvDgTJ0=;
        b=kIj/mJ4KTD8MPrBIY5pFPqiuvHDVrYykLIb/BRGzifdAAJT6FHdvAkOmh1o8tEM4i5
         SeJCNRVMQAfGKhcPQ2EKlgWikY+zaagZPNj0r4aE9BKXuk80YN8Jzd7yopJBJg4Z9+4d
         6Ph3eeJzaNYBHdBg3reqskrEBxFXT/SkPhwMORcKIbMIp9uy/O0Z8Khmjlg+554fj409
         UOOOU4a3W/TVd79B5cSNkbgA/cFhI6B0WzZ6pf9IrzbF94LfwVEWzuE3vuH8agrONEQU
         4ssQZ5xKRP2YiEuR/NRO+jXhhmiePp6+TwZk1IV9xLgS6OX2Sgo9Rypr43w5iAOcf0EH
         r5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3sGhycMBJPPvv45Cb1ionNhosmVwz+OP/TrPvDgTJ0=;
        b=Gxa+tHMUD+3RZ/3mzFDQegc2x0t/DotcdFOgSnlFBfJyBfWCKrt+2q3WB8q7yxkJh3
         Py8iRbWoeoBcYtPEkO4wuVS/djQjNrgLKNdifmm4G1v9XWi5ldx2ROlivy248SCcxHpO
         4ejqSpgbyJqqI1Ng0pawKC4dSL3PNp1sY4R3WEVgjnKNFQU1i0QiX4f7y77YRxmGVuEl
         P6DOy1kpqralvLx08vxub8H5lHdMmP0wF4fLgxW+IAbgII+rAEQ6T2arfIR7V+PUkJlC
         SoU/N4szuzOHWdInh1IqMN2cc4x5X4FGQNUSflWGvqgE1QGQiqFzRI96X1gU6ho7u94M
         h7SA==
X-Gm-Message-State: AOAM531rlgNSDOvs3LTiAFqFWysAgUUbOvKz5SDB4ofF+Feu73v/D+fi
        5F8bk33RJrRZq7RuD3x1YiQ=
X-Google-Smtp-Source: ABdhPJzrn8oT/GPHekc6zahcsIxw2pbHI1/yUYr8IdNtF/Xy+C+t6ASf1OxYOLz7ohWrnLq0vDd2mQ==
X-Received: by 2002:ac8:4b67:: with SMTP id g7mr21181952qts.247.1616994984417;
        Sun, 28 Mar 2021 22:16:24 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:23 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/23] sparc: dax-hv-api.txt: Fix quite a few spellos
Date:   Mon, 29 Mar 2021 10:42:53 +0530
Message-Id: <bbd787195af822f1ba7faddaf3f1760b0f7015ba.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/indicies/indices/
s/retricted/restricted/
s/indentifier/identifier/   ....two different places.
s/proccessed/processed/     ....three different places.


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/sparc/oradax/dax-hv-api.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/sparc/oradax/dax-hv-api.txt b/Documentation/sparc/oradax/dax-hv-api.txt
index 73e8d506cf64..300fbb58ad04 100644
--- a/Documentation/sparc/oradax/dax-hv-api.txt
+++ b/Documentation/sparc/oradax/dax-hv-api.txt
@@ -742,7 +742,7 @@ Offset   Size   Field Description
         code in the CCB header.

         There are two supported formats for the output stream: the bit vector and index array formats (codes 0x8,
-        0xD, and 0xE). The index array format is an array of indicies of bits which would have been set if the
+        0xD, and 0xE). The index array format is an array of indices of bits which would have been set if the
         output format was a bit array.

         The return value of the CCB completion area contains the number of bits set in the output bit vector,
@@ -1254,7 +1254,7 @@ EUNAVAILABLE   The requested CCB operation could not be performed at this time.
                submitted CCB, or may apply to a larger scope. The status should not be
                interpreted as permanent, and the guest should attempt to submit CCBs in
                the future which had previously been unable to be performed. The status
-               data provides additional information about scope of the retricted availability
+               data provides additional information about scope of the restricted availability
                as follows:
                Value       Description
                0           Processing for the exact CCB instance submitted was unavailable,
@@ -1330,20 +1330,20 @@ EUNAVAILABLE   The requested CCB operation could not be performed at this time.
          of other CCBs ahead of the requested CCB, to provide a relative estimate of when the CCB may execute.

          The dax return value is only valid when the state is ENQUEUED. The value returned is the DAX unit
-         instance indentifier for the DAX unit processing the queue where the requested CCB is located. The value
+         instance identifier for the DAX unit processing the queue where the requested CCB is located. The value
          matches the value that would have been, or was, returned by ccb_submit using the queue info flag.

          The queue return value is only valid when the state is ENQUEUED. The value returned is the DAX
-         queue instance indentifier for the DAX unit processing the queue where the requested CCB is located. The
+         queue instance identifier for the DAX unit processing the queue where the requested CCB is located. The
          value matches the value that would have been, or was, returned by ccb_submit using the queue info flag.

 36.3.2.1. Errors

-          EOK                       The request was proccessed and the CCB state is valid.
+          EOK                       The request was processed and the CCB state is valid.
           EBADALIGN                 address is not on a 64-byte aligned.
           ENORADDR                  The real address provided for address is not valid.
           EINVAL                    The CCB completion area contents are not valid.
-          EWOULDBLOCK               Internal resource contraints prevented the CCB state from being queried at this
+          EWOULDBLOCK               Internal resource constraints prevented the CCB state from being queried at this
                                     time. The guest should retry the request.
           ENOACCESS                 The guest does not have permission to access the coprocessor virtual device
                                     functionality.
@@ -1401,11 +1401,11 @@ EUNAVAILABLE   The requested CCB operation could not be performed at this time.

 36.3.3.2. Errors

-          EOK                        The request was proccessed and the result is valid.
+          EOK                        The request was processed and the result is valid.
           EBADALIGN                  address is not on a 64-byte aligned.
           ENORADDR                   The real address provided for address is not valid.
           EINVAL                     The CCB completion area contents are not valid.
-          EWOULDBLOCK                Internal resource contraints prevented the CCB from being killed at this time.
+          EWOULDBLOCK                Internal resource constraints prevented the CCB from being killed at this time.
                                      The guest should retry the request.
           ENOACCESS                  The guest does not have permission to access the coprocessor virtual device
                                      functionality.
@@ -1423,7 +1423,7 @@ EUNAVAILABLE   The requested CCB operation could not be performed at this time.

 36.3.4.1. Errors

-          EOK                        The request was proccessed and the number of enabled/disabled DAX units
+          EOK                        The request was processed and the number of enabled/disabled DAX units
                                      are valid.


--
2.26.3

