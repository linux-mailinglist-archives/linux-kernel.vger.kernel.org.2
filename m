Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C33316710
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhBJMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:46:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40902 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhBJMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:45:00 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l9opz-0002dr-49; Wed, 10 Feb 2021 12:43:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Wed, 10 Feb 2021 12:43:18 +0000
Message-Id: <20210210124318.55082-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are some of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel since September 2020

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index a47006de990e..2e3ba91a5072 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -340,6 +340,7 @@ comppatible||compatible
 compres||compress
 compresion||compression
 comression||compression
+comunicate||communicate
 comunication||communication
 conbination||combination
 conditionaly||conditionally
@@ -467,6 +468,7 @@ developpment||development
 deveolpment||development
 devided||divided
 deviece||device
+devision||division
 diable||disable
 dicline||decline
 dictionnary||dictionary
@@ -480,6 +482,7 @@ difinition||definition
 digial||digital
 dimention||dimension
 dimesions||dimensions
+diconnected||disconnected
 disgest||digest
 dispalying||displaying
 diplay||display
@@ -519,6 +522,7 @@ downlads||downloads
 droped||dropped
 droput||dropout
 druing||during
+dyanmic||dynamic
 dynmaic||dynamic
 eanable||enable
 eanble||enable
@@ -543,6 +547,7 @@ encrupted||encrypted
 encrypiton||encryption
 encryptio||encryption
 endianess||endianness
+enpoint||endpoint
 enhaced||enhanced
 enlightnment||enlightenment
 enqueing||enqueuing
@@ -644,6 +649,7 @@ forwardig||forwarding
 frambuffer||framebuffer
 framming||framing
 framwork||framework
+frequence||frequency
 frequncy||frequency
 frequancy||frequency
 frome||from
@@ -686,10 +692,12 @@ handfull||handful
 hanlde||handle
 hanled||handled
 happend||happened
+hardare||hardware
 harware||hardware
 havind||having
 heirarchically||hierarchically
 helpfull||helpful
+heterogenous||heterogeneous
 hexdecimal||hexadecimal
 hybernate||hibernate
 hierachy||hierarchy
@@ -734,6 +742,7 @@ inconsistant||inconsistent
 increas||increase
 incremeted||incremented
 incrment||increment
+incuding||including
 inculde||include
 indendation||indentation
 indended||intended
@@ -744,6 +753,7 @@ indiate||indicate
 indicat||indicate
 inexpect||inexpected
 inferface||interface
+infinit||infinite
 infomation||information
 informatiom||information
 informations||information
@@ -774,6 +784,7 @@ instace||instance
 instal||install
 instanciate||instantiate
 instanciated||instantiated
+instuments||instruments
 insufficent||insufficient
 inteface||interface
 integreated||integrated
@@ -872,6 +883,7 @@ mailformed||malformed
 malplaced||misplaced
 malplace||misplace
 managable||manageable
+managament||management
 managment||management
 mangement||management
 manger||manager
@@ -890,6 +902,7 @@ meetign||meeting
 memeory||memory
 memmber||member
 memoery||memory
+memroy||memory
 ment||meant
 mergable||mergeable
 mesage||message
@@ -1003,6 +1016,7 @@ overlaping||overlapping
 overide||override
 overrided||overridden
 overriden||overridden
+overrrun||overrun
 overun||overrun
 overwritting||overwriting
 overwriten||overwritten
@@ -1039,6 +1053,7 @@ peforming||performing
 peice||piece
 pendantic||pedantic
 peprocessor||preprocessor
+perfomance||performance
 perfoming||performing
 perfomring||performing
 periperal||peripheral
@@ -1104,6 +1119,7 @@ prodecure||procedure
 progamming||programming
 progams||programs
 progess||progress
+programable||programmable
 programers||programmers
 programm||program
 programms||programs
@@ -1148,6 +1164,7 @@ recieved||received
 recieve||receive
 reciever||receiver
 recieves||receives
+recieving||receiving
 recogniced||recognised
 recognizeable||recognizable
 recommanded||recommended
@@ -1251,6 +1268,7 @@ searchs||searches
 secquence||sequence
 secund||second
 segement||segment
+seleted||selected
 semaphone||semaphore
 senario||scenario
 senarios||scenarios
@@ -1267,6 +1285,7 @@ seqeunce||sequence
 seqeuncer||sequencer
 seqeuencer||sequencer
 sequece||sequence
+sequemce||sequence
 sequencial||sequential
 serivce||service
 serveral||several
@@ -1337,6 +1356,7 @@ suble||subtle
 substract||subtract
 submited||submitted
 submition||submission
+succeded||succeeded
 suceed||succeed
 succesfully||successfully
 succesful||successful
@@ -1357,6 +1377,7 @@ supportin||supporting
 suppoted||supported
 suppported||supported
 suppport||support
+supprot||support
 supress||suppress
 surpressed||suppressed
 surpresses||suppresses
@@ -1405,6 +1426,7 @@ thresold||threshold
 throught||through
 trackling||tracking
 troughput||throughput
+trys||tries
 thses||these
 tiggers||triggers
 tiggered||triggered
@@ -1418,7 +1440,9 @@ traking||tracking
 tramsmitted||transmitted
 tramsmit||transmit
 tranasction||transaction
+tranceiver||transceiver
 tranfer||transfer
+tranmission||transmission
 transcevier||transceiver
 transciever||transceiver
 transferd||transferred
@@ -1472,6 +1496,7 @@ unnecesary||unnecessary
 unneedingly||unnecessarily
 unnsupported||unsupported
 unmached||unmatched
+unprecise||imprecise
 unregester||unregister
 unresgister||unregister
 unrgesiter||unregister
@@ -1507,6 +1532,7 @@ varient||variant
 vaule||value
 verbse||verbose
 veify||verify
+veriosn||version
 verisons||versions
 verison||version
 verson||version
-- 
2.30.0

