Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E794083BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhIMFQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIMFQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:16:26 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609CC061574;
        Sun, 12 Sep 2021 22:15:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h20so7846542ilj.13;
        Sun, 12 Sep 2021 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Fym7Ho3/HB4lYkhNEdo9I/OHj12nal5b2UIn6CWREBk=;
        b=qGn3WBtr47uclRtIV3dRAGzWNWa0BFeOnorOzw5Oz6w6Bodo4vRBRO36bij6VxDuD6
         YqkGNEkfaBxqpJRMzH9mtvgfMSB8voc9L5MbjSIHrbEiD5jTmXUJ14lOJXmdzeumXQGt
         BvByBr89FKobLzw275YRxYKfwWyoqyTh9PhP8grJflJKi94e++6/eLYX88VNrCrv4qbA
         8sYHVtIavqCkaWYfR20gHcj7tpBnLfosvhXbFiMJn6tZg944SWfoeJhVf+t/pkY3ez/E
         MwnzncticLhlM+i8We6/JWwd2onZF/JhTWVidXnsTDGo/XjNKRw+fM+HyXD4c/t7nUtW
         YTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fym7Ho3/HB4lYkhNEdo9I/OHj12nal5b2UIn6CWREBk=;
        b=JOPCwsCwN3+r+twnXkq7p+yuYeqQBiaGc+TB42/YG3b1emZA8T9cUiFc/xeeXg76YS
         TcbfpWLfpzINbDg5h0ZRRKVsNnCQPCLbH2rI+Ib64I9MeOBWFeo1RI0kcLGkyONruuNl
         bwpWrDQCSd1/+10qSUnUyjpIRlEelrw87//Wdio1fj/xH4T4sQiWNwx5WIPa4m4JkjsQ
         kwHbC6En8nHnQG+rxqVJnLHbC/whWzb7VPiDVilFoiLreegzhBR3c5OHD+lwQLJQr4of
         Rkmc/WTMiKrE3ck+csUF+aycOpe2UcUIYV4TixRy8nNDSaB9IhLEi+TjeKzj8Y28eXFS
         cBdA==
X-Gm-Message-State: AOAM532VYcV0G6SeroDqAx1XQJ690x+E07Q7p390zYl1ZPoXIsuHmJi+
        hWW0XayiGQh+LjFSXLNZjly35dh0XgNieYn2SLHt8Bbg2YE=
X-Google-Smtp-Source: ABdhPJwXcuPacVX3Si/EYs85Sy+ueqZTP34GmxqYuIVM2FfaSeF/jjBHYkni4aXXfaLv1ELoLBH3/WmEtLu4Q0KOLXc=
X-Received: by 2002:a05:6e02:120e:: with SMTP id a14mr6603429ilq.222.1631510111123;
 Sun, 12 Sep 2021 22:15:11 -0700 (PDT)
MIME-Version: 1.0
From:   zhao xc <xinchao.zhao.kernelz@gmail.com>
Date:   Mon, 13 Sep 2021 13:15:00 +0800
Message-ID: <CAP7CzPcc40RobQfMLPkW3TXkEf1b7B7Xd_ufFBh76LKoegiqeQ@mail.gmail.com>
Subject: 
To:     ysato@users.sourceforge.jp
Cc:     dalias@libc.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, xinchao.zhao@ucas.com.cn
Content-Type: multipart/mixed; boundary="0000000000009f21ef05cbd98c83"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009f21ef05cbd98c83
Content-Type: text/plain; charset="UTF-8"

Hi maintainer:
    This is a patch fix the unused macro definition
Thanks!

--0000000000009f21ef05cbd98c83
Content-Type: application/octet-stream; 
	name="0001-arch-sh-fix-the-unused-macro-definition-IP_NF_MATCH_.patch"
Content-Disposition: attachment; 
	filename="0001-arch-sh-fix-the-unused-macro-definition-IP_NF_MATCH_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kti6xv5p0>
X-Attachment-Id: f_kti6xv5p0

RnJvbSA3M2YyMWY3ZTBhNDdlZTI3NmY5YTQ4NjFlNDFmNWFjNjA1NzVhNjY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB6aGFveGluY2hhbyA8d2FuZ2h1b0B1Y2FzLmNvbS5jbj4KRGF0
ZTogVGh1LCA5IFNlcCAyMDIxIDAyOjMyOjU2IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gYXJjaDog
c2g6IGZpeCB0aGUgdW51c2VkIG1hY3JvIGRlZmluaXRpb24KIElQX05GX01BVENIX0FERFJUWVBF
LiBJUF9ORl9NQVRDSF9BRERSVFlQRSBoYXMgY2hhbmdlZCB0bwogTkVURklMVEVSX1hUX01BVENI
X0FERFJUWVBFIGluIDIwMTEuIENPTkZJR19JUF9ORl9UQVJHRVRfTE9HIGRvZXMgbm90IGV4aXN0
CiBpbiB0aGUga2VybmVsLgoKc2VlIHRoZSBjb21taXQgPGRlODFiYmVhMTc2NTA3Njk4ODJiYzYy
NWQ2YjVkZjExZWU3YzRiMjQ+CgpTaWduZWQtb2ZmLWJ5OiB6aGFveGluY2hhbyA8d2FuZ2h1b0B1
Y2FzLmNvbS5jbj4KLS0tCiBhcmNoL3NoL2NvbmZpZ3MvdGl0YW5fZGVmY29uZmlnIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvYXJjaC9zaC9jb25maWdzL3RpdGFuX2RlZmNvbmZpZyBiL2FyY2gvc2gvY29uZmlncy90aXRh
bl9kZWZjb25maWcKaW5kZXggYmE4ODdmMTM1MWJlLi5hOGI0YTlkMzkzYmUgMTAwNjQ0Ci0tLSBh
L2FyY2gvc2gvY29uZmlncy90aXRhbl9kZWZjb25maWcKKysrIGIvYXJjaC9zaC9jb25maWdzL3Rp
dGFuX2RlZmNvbmZpZwpAQCAtODMsNyArODMsNyBAQCBDT05GSUdfSVBfTkZfTUFUQ0hfRUNOPW0K
IENPTkZJR19JUF9ORl9NQVRDSF9UVEw9bQogQ09ORklHX0lQX05GX0ZJTFRFUj1tCiBDT05GSUdf
SVBfTkZfVEFSR0VUX1JFSkVDVD1tCi1DT05GSUdfSVBfTkZfVEFSR0VUX0xPRz1tCitDT05GSUdf
TkVURklMVEVSX1hUX1RBUkdFVF9MT0c9bQogQ09ORklHX0lQX05GX01BTkdMRT1tCiBDT05GSUdf
SVBfTkZfVEFSR0VUX0VDTj1tCiBDT05GSUdfSVBfTkZfVEFSR0VUX1RUTD1tCi0tIAoyLjE3LjEK
Cg==
--0000000000009f21ef05cbd98c83--
