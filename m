Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01561380658
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhENJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:38:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36570 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhENJiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:38:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lhUFc-00073Z-67; Fri, 14 May 2021 09:36:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Fri, 14 May 2021 10:36:55 +0100
Message-Id: <20210514093655.8829-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are some of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel in the past few
months.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 7b6a01291598..17fdc620d548 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -22,6 +22,7 @@ absolut||absolute
 absoulte||absolute
 acccess||access
 acceess||access
+accelaration||acceleration
 acceleratoin||acceleration
 accelleration||acceleration
 accesing||accessing
@@ -264,6 +265,7 @@ calucate||calculate
 calulate||calculate
 cancelation||cancellation
 cancle||cancel
+canot||cannot
 capabilites||capabilities
 capabilties||capabilities
 capabilty||capability
@@ -494,7 +496,10 @@ digial||digital
 dimention||dimension
 dimesions||dimensions
 diconnected||disconnected
+disabed||disabled
+disble||disable
 disgest||digest
+disired||desired
 dispalying||displaying
 diplay||display
 directon||direction
@@ -710,6 +715,7 @@ havind||having
 heirarchically||hierarchically
 heirarchy||hierarchy
 helpfull||helpful
+hearbeat||heartbeat
 heterogenous||heterogeneous
 hexdecimal||hexadecimal
 hybernate||hibernate
@@ -989,6 +995,7 @@ notications||notifications
 notifcations||notifications
 notifed||notified
 notity||notify
+nubmer||number
 numebr||number
 numner||number
 obtaion||obtain
@@ -1014,8 +1021,10 @@ ommiting||omitting
 ommitted||omitted
 onself||oneself
 ony||only
+openning||opening
 operatione||operation
 opertaions||operations
+opportunies||opportunities
 optionnal||optional
 optmizations||optimizations
 orientatied||orientated
@@ -1111,6 +1120,7 @@ prefitler||prefilter
 preform||perform
 premption||preemption
 prepaired||prepared
+prepate||prepare
 preperation||preparation
 preprare||prepare
 pressre||pressure
@@ -1123,6 +1133,7 @@ privilaged||privileged
 privilage||privilege
 priviledge||privilege
 priviledges||privileges
+privleges||privileges
 probaly||probably
 procceed||proceed
 proccesors||processors
@@ -1167,6 +1178,7 @@ promixity||proximity
 psudo||pseudo
 psuedo||pseudo
 psychadelic||psychedelic
+purgable||purgeable
 pwoer||power
 queing||queuing
 quering||querying
@@ -1180,6 +1192,7 @@ receieve||receive
 recepient||recipient
 recevied||received
 receving||receiving
+recievd||received
 recieved||received
 recieve||receive
 reciever||receiver
@@ -1228,6 +1241,7 @@ reponse||response
 representaion||representation
 reqeust||request
 reqister||register
+requed||requeued
 requestied||requested
 requiere||require
 requirment||requirement
@@ -1332,6 +1346,7 @@ singal||signal
 singed||signed
 sleeped||slept
 sliped||slipped
+softwade||software
 softwares||software
 soley||solely
 souce||source
@@ -1510,6 +1525,7 @@ unintialized||uninitialized
 unitialized||uninitialized
 unkmown||unknown
 unknonw||unknown
+unknouwn||unknown
 unknow||unknown
 unkown||unknown
 unamed||unnamed
-- 
2.30.2

