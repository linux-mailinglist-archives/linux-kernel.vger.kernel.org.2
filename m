Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C140F6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343977AbhIQL3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:29:42 -0400
Received: from 186.250.87.110.broad.sm.fj.dynamic.163data.com.cn ([110.87.250.186]:51081
        "EHLO kh54hq.top" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbhIQL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:29:39 -0400
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 07:29:39 EDT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=kh54hq.top;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kefu@kh54hq.top;
 bh=8eyy6m7YFxjEsAjSUIAV8I6zSBU=;
 b=rC70pynrZ1rXzTQbwuA21Z9v1SwDw6QgGhx7pYkxnbCLuLvtz+vhi03rvYapocfwBKfKBHposp7g
   FkXdSPhuqsh8NWRzlCxM2nsK70b4VQdaUN/0Cjv2RSeBMaC98PYT/1gfj55q31AXd1y9Rr2v4MvX
   m+PPvaZpEUb5otGQW00=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=kh54hq.top;
 b=skrehcdUssW1Ph8awa512dglV3ArU0eNwu65/gnROBp+bsJJvDcUok2sJXT2OSWEhLJyk1Ov5WkB
   U79G6b7JF7uBr1GNhulk2NZimoTat4o5oHuFbsTyXIVIc4DT5A5uM14D1BxxjF9QoS0TUfEWb2xB
   NUnKmOebCGQkOiEEq1o=;
Message-ID: <20210917190720467822@kh54hq.top>
From:   =?utf-8?B?77yl77y077yj44K144O844OT44K544Gu44GK55+l44KJ44Gb?= 
        <kefu@kh54hq.top>
To:     <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?RVRD44K144O844OT44K5?=
Date:   Fri, 17 Sep 2021 19:07:07 +0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-mailer: Nkrqdyv 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RVRD44K144O844OT44K544KS44GU5Yip55So44Gu44GK5a6i5qeYOg0KDQpFVEPjgrXjg7zjg5Pj
grnjga/nhKHlirnjgavjgarjgorjgb7jgZfjgZ/jgIINCuW8leOBjee2muOBjeOCteODvOODk+OC
ueOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBjeOBn+OBhOWgtOWQiOOBr+OAgeS4i+iomOODquODs+OC
r+OCiOOCiuips+e0sOOCkuOBlOeiuuiqjeOBj+OBoOOBleOBhOOAgg0KDQrkuIvoqJjjga7mjqXn
tprjgYvjgonlgZzmraLljp/lm6DjgpLnorroqo3jgZfjgabjgY/jgaDjgZXjgYQNCg0KaHR0cHM6
Ly9ldGMtbWVpc2FpLmpwLnRuLWluZm8udG9wDQoNCijnm7TmjqXjgqLjgq/jgrvjgrnjgafjgY3j
garjgYTloLTlkIjjga/jgIHmiYvli5Xjgafjg5bjg6njgqbjgrbjgavjgrPjg5Tjg7zjgZfjgabp
lovjgYTjgabjgY/jgaDjgZXjgYQpDQoNCuKAu+OBk+OBruODoeODvOODq+OBr+mAgeS/oeWwgueU
qOOBp+OBmeOAgg0K44CA44GT44Gu44Ki44OJ44Os44K544Gr6YCB5L+h44GE44Gf44Gg44GE44Gm
44KC6L+U5L+h44GE44Gf44GX44GL44Gt44G+44GZ44Gu44Gn44CB44GC44KJ44GL44GY44KB44GU
5LqG5om/6aGY44GE44G+44GZ44CCDQrigLvjgarjgYrjgIHjgZTkuI3mmI7jgarngrnjgavjgaTj
gY3jgb7jgZfjgabjga/jgIHjgYrmiYvmlbDjgafjgZnjgYzjgIENCiAgRVRD44K144O844OT44K5
5LqL5YuZ5bGA44Gr44GK5ZWP44GE5ZCI44KP44Gb44GP44Gg44GV44GE44CCDQoNCuKWoEVUQ+WI
qeeUqOeFp+S8muOCteODvOODk+OCueS6i+WLmeWxgA0K5bm05Lit54Sh5LyR44CAOTowMO+9njE4
OjAwDQrjg4rjg5Pjg4DjgqTjg6Tjg6vjgIAwNTcwLTAxMDEzOQ0K77yI44OK44OT44OA44Kk44Ok
44Or44GM44GU5Yip55So44GE44Gf44Gg44GR44Gq44GE44GK5a6i44GV44G+44CAMDQ1LTc0NC0x
Mzcy77yJDQowNDUtNzQ0LTk5MA==


