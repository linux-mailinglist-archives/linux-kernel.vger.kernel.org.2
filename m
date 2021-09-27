Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A694192DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhI0LMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233960AbhI0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45693610E8;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=AqDRSHU2BAg7akPKyY0rqmG5N9F1Y4zESlaVfKItUWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/5jo6Kl36QK8LcKcq7HXuX+ecO8WBFRu/W4xW6cjCg+8AFBjtYGU7zz2IM+rP/4a
         5a2h3nMuFLOdy9yJDjCdtkN95gnbpTzPyLW/5oWFG292oyDn3arkbHpv9tbxYuU3/S
         mGazF6NK0QFTlDrlKaLcAEP2GcItcJqIjnOYxXe28dV1OvXd0JGEc5J2bxhQB7255c
         3Koz02Sa7jM7L3Yx75tY8Dqa8yXud3vRMBLLhY4jCR5ltRRL2TEt3RM8ipB4zJVi1M
         xF3pFF4gLVuzWiTuHsaXfHmYVThudwqkyEWNt3SMpLH1cHhw3G8T/6s52xOGa7ROjs
         XkyGR3PJyaKwA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005y9-8H; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] scripts: get_abi.pl: create a valid ReST with duplicated tags
Date:   Mon, 27 Sep 2021 13:10:50 +0200
Message-Id: <4ad2e3a65f781f0f8d40bb75aa5a07aca80564d6.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632740376.git.mchehab+huawei@kernel.org>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned, /sys/bus/iio/devices/iio:deviceX/fault_ovuv is defined 2 times:

	Warning: /sys/bus/iio/devices/iio:deviceX/fault_ovuv is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856:14  ./Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865:0

The logic with joins the two entries is just places the paragraph
for the second entry after the previous one. That could cause more
warnings, as the produced ReST may become invalid, as in the case of
this specific symbol, which ends with a table:

	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856:2: WARNING: Malformed table.
	No bottom table border found or no blank line after table bottom.

	===  =======================================================
	'1'  The input voltage is negative or greater than VDD.
	'0'  The input voltage is positive and less than VDD (normal
	     state).
	===  =======================================================
	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856:2: WARNING: Blank line required after table.

Address it by adding two blank lines before joining duplicated
symbols.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t

 scripts/get_abi.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f25c98b1971e..c191c024f052 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -180,6 +180,7 @@ sub parse_abi {
 						$data{$what}->{file} = $name;
 						$data{$what}->{filepath} = $file;
 					} else {
+						$data{$what}->{description} .= "\n\n" if (defined($data{$what}->{description}));
 						if ($name ne $data{$what}->{file}) {
 							$data{$what}->{file} .= " " . $name;
 							$data{$what}->{filepath} .= " " . $file;
-- 
2.31.1

