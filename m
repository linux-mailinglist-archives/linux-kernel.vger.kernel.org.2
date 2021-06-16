Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59F63A9A28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhFPM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:28:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4814 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhFPM2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:28:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4knX5kLFzXfv2;
        Wed, 16 Jun 2021 20:21:36 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:38 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 3/3] scripts/spelling.txt: add some spelling "mistake||correction" pairs
Date:   Wed, 16 Jun 2021 20:25:07 +0800
Message-ID: <20210616122507.896-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210616122507.896-1-thunder.leizhen@huawei.com>
References: <20210616122507.896-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is all the spelling mistakes I've fixed so far.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 scripts/spelling.txt | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 8cb320ecfc8c..2f13558681f5 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -45,6 +45,7 @@ accordign||according
 accoring||according
 acording||according
 accout||account
+accouting||accounting
 accumalate||accumulate
 acumulating||accumulating
 acumulative||accumulative
@@ -90,6 +91,7 @@ againt||against
 agaist||against
 aggreataon||aggregation
 aggreation||aggregation
+aggresive||aggressive
 albumns||albums
 algorithmn||algorithm
 algorith||algorithm
@@ -112,9 +114,13 @@ allocte||allocate
 alocate||allocate
 alloated||allocated
 allocatrd||allocated
+alloced||allocated
 allocted||allocated
+alocated||allocated
 alow||allow
 alows||allows
+alpha-numeric||alphanumeric
+alread||already
 alreay||already
 alredy||already
 altough||although
@@ -122,6 +128,7 @@ abigious||ambiguous
 ambigious||ambiguous
 ambigous||ambiguous
 amoung||among
+ammount||amount
 amout||amount
 amplifer||amplifier
 amplifyer||amplifier
@@ -132,6 +139,7 @@ anniversery||anniversary
 annoucement||announcement
 anomolies||anomalies
 anomoly||anomaly
+aother||another
 anway||anyway
 appearence||appearance
 allpication||application
@@ -167,14 +175,17 @@ asign||assign
 assgined||assigned
 assiged||assigned
 assigment||assignment
+assignement||assignment
 assigments||assignments
 assistent||assistant
 assocaited||associated
 associcated||associated
 assotiated||associated
+asssociated||associated
 assocating||associating
 assocation||association
 assum||assume
+asumed||assumed
 asuming||assuming
 assumtpion||assumption
 asymetric||asymmetric
@@ -204,7 +215,9 @@ automatizes||automates
 atomatically||automatically
 automaticaly||automatically
 automaticly||automatically
+automtically||automatically
 autonymous||autonomous
+auxilary||auxiliary
 auxillary||auxiliary
 auxilliary||auxiliary
 availablity||availability
@@ -304,6 +317,7 @@ childern||children
 childs||children
 chouse||chose
 choosen||chosen
+cipherntext||ciphertext
 circumvernt||circumvent
 claread||cleared
 clared||cleared
@@ -346,6 +360,7 @@ complient||compliant
 compoment||component
 componnents||components
 compres||compress
+compresed||compressed
 compresion||compression
 comression||compression
 conditon||condition
@@ -369,6 +384,7 @@ connectinos||connections
 connnections||connections
 conector||connector
 connetor||connector
+conervative||conservative
 conider||consider
 consistancy||consistency
 consistant||consistent
@@ -378,6 +394,7 @@ contruction||construction
 comsume||consume
 comsumer||consumer
 comsuming||consuming
+consumtion||consumption
 contant||contact
 containes||contains
 containts||contains
@@ -396,12 +413,15 @@ contoller||controller
 controler||controller
 convienient||convenient
 convinient||convenient
+convetion||convention
 convertion||conversion
 convertor||converter
 corected||corrected
 correponding||corresponding
 correspoding||corresponding
+correspondig||corresponding
 correponds||corresponds
+corresonds||corresponds
 cound||could
 couter||counter
 coutner||counter
@@ -409,9 +429,11 @@ cunter||counter
 contry||country
 conuntry||country
 cryptocraphic||cryptographic
+curremt||current
 curently||currently
 cylic||cyclic
 deamon||daemon
+datas||data
 detabase||database
 deactive||deactivate
 desactivate||deactivate
@@ -422,6 +444,7 @@ delares||declares
 delaring||declaring
 dicline||decline
 decompres||decompress
+deompression||decompression
 dafault||default
 deafult||default
 defailt||default
@@ -444,12 +467,15 @@ delievered||delivered
 demodualtor||demodulator
 dependancies||dependencies
 dependancy||dependency
+dependeny||dependency
 dependant||dependent
 dependend||dependent
 depreacte||deprecate
 depreacted||deprecated
+dervied||derived
 decendant||descendant
 decendants||descendants
+desribe||describe
 decsribed||described
 decription||description
 descripton||description
@@ -472,6 +498,7 @@ destorys||destroys
 detectt||detect
 dectected||detected
 deteced||detected
+determin||determine
 develope||develop
 developped||developed
 developper||developer
@@ -496,6 +523,7 @@ dimesions||dimensions
 directon||direction
 direcly||directly
 direectly||directly
+dirtyness||dirtiness
 diable||disable
 disbale||disable
 disble||disable
@@ -526,9 +554,11 @@ divsiors||divisors
 documment||document
 docuentation||documentation
 documantation||documentation
+documenation||documentation
 documentaion||documentation
 dosen||doesn
 doesnt||doesn't
+dont't||don't
 donwload||download
 downlad||download
 donwloading||downloading
@@ -536,6 +566,7 @@ downlads||downloads
 dorp||drop
 droput||dropout
 droped||dropped
+droppped||dropped
 druing||during
 dyanmic||dynamic
 dynmaic||dynamic
@@ -546,6 +577,7 @@ efective||effective
 effectivness||effectiveness
 efficently||efficiently
 eigth||eight
+ether||either
 eletronic||electronic
 elementry||elementary
 embeded||embedded
@@ -559,6 +591,7 @@ encrupted||encrypted
 encrypiton||encryption
 encryptio||encryption
 endianess||endianness
+endoint||endpoint
 enpoint||endpoint
 enchanced||enhanced
 enhaced||enhanced
@@ -599,8 +632,10 @@ execeeds||exceeds
 exeeds||exceeds
 excellant||excellent
 exlcude||exclude
+exlude||exclude
 exlcusive||exclusive
 excecutable||executable
+excute||execute
 exeuction||execution
 exixt||exist
 existance||existence
@@ -640,6 +675,7 @@ feauture||feature
 fetaure||feature
 feautures||features
 fetaures||features
+feeded||fed
 fileystem||filesystem
 finanize||finalize
 finilizes||finalizes
@@ -651,6 +687,7 @@ firmare||firmware
 firmaware||firmware
 firware||firmware
 firwmare||firmware
+flaged||flagged
 flusing||flushing
 folloing||following
 followign||following
@@ -673,6 +710,7 @@ fucntion||function
 fuction||function
 funcation||function
 funcion||function
+funciton||function
 funtion||function
 functionallity||functionality
 functionnality||functionality
@@ -719,6 +757,8 @@ heirarchically||hierarchically
 heirarchy||hierarchy
 hierachy||hierarchy
 hierarchie||hierarchy
+hierarhcy||hierarchy
+higer||higher
 homogenous||homogeneous
 howver||however
 hypter||hyper
@@ -769,9 +809,11 @@ independed||independent
 independantly||independently
 indiate||indicate
 indicat||indicate
+indicies||indices
 invididual||individual
 inexpect||inexpected
 infinit||infinite
+inifinite||infinite
 infomation||information
 informatiom||information
 informations||information
@@ -800,6 +842,8 @@ initilized||initialized
 intiailized||initialized
 intialized||initialized
 initialzing||initializing
+intializing||initializing
+initate||initiate
 initation||initiation
 initators||initiators
 instal||install
@@ -828,6 +872,8 @@ intermittant||intermittent
 interanl||internal
 internel||internal
 interoprability||interoperability
+intepreted||interpreted
+interpeter||interpreter
 interrrupt||interrupt
 interrup||interrupt
 interupt||interrupt
@@ -835,6 +881,7 @@ interuupt||interrupt
 intrerrupt||interrupt
 intrrupt||interrupt
 intterrupt||interrupt
+interruped||interrupted
 interruptted||interrupted
 interupted||interrupted
 interrups||interrupts
@@ -874,6 +921,7 @@ langauage||language
 langauge||language
 langugage||language
 lauch||launch
+leaset||least
 legnth||length
 lenght||length
 lengh||length
@@ -912,6 +960,7 @@ manufaucturing||manufacturing
 mnay||many
 maping||mapping
 mappping||mapping
+markes||marks
 matchs||matches
 mathimatic||mathematic
 mathimatical||mathematical
@@ -987,6 +1036,7 @@ neded||needed
 negaive||negative
 negoitation||negotiation
 negotation||negotiation
+netiher||neither
 nerver||never
 noticable||noticeable
 notication||notification
@@ -999,6 +1049,7 @@ nubmer||number
 numebr||number
 numner||number
 obtaion||obtain
+obious||obvious
 occassionally||occasionally
 occationally||occasionally
 occurd||occurred
@@ -1054,6 +1105,7 @@ pakage||package
 paket||packet
 packtes||packets
 pallette||palette
+panicing||panicking
 paramater||parameter
 paramter||parameter
 pramater||parameter
@@ -1083,6 +1135,7 @@ perfomring||performing
 peroid||period
 periperal||peripheral
 peripherial||peripheral
+permanentely||permanently
 permissons||permissions
 persistance||persistence
 persistant||persistent
@@ -1099,10 +1152,13 @@ plugable||pluggable
 poinnter||pointer
 pointeur||pointer
 poiter||pointer
+posion||poison
 protable||portable
 positon||position
+possitive||positive
 possibilites||possibilities
 posible||possible
+potentialy||potentially
 pwoer||power
 powerfull||powerful
 preamle||preamble
@@ -1111,6 +1167,7 @@ preceed||precede
 preceeded||preceded
 precendence||precedence
 preceeding||preceding
+precisly||precisely
 precission||precision
 preemptable||preemptible
 premption||preemption
@@ -1123,6 +1180,7 @@ prepate||prepare
 preprare||prepare
 prepaired||prepared
 peprocessor||preprocessor
+presense||presence
 pressre||pressure
 presuambly||presumably
 previosuly||previously
@@ -1227,6 +1285,7 @@ reguator||regulator
 releated||related
 relevent||relevant
 reloade||reload
+remaning||remaining
 remoote||remote
 remore||remote
 removeable||removable
@@ -1268,6 +1327,7 @@ ressources||resources
 repectively||respectively
 reponse||response
 responce||response
+resposible||responsible
 resumbmitting||resubmitting
 restesting||retesting
 retransmited||retransmitted
@@ -1306,6 +1366,7 @@ segement||segment
 seleted||selected
 semaphone||semaphore
 sentivite||sensitive
+sentinal||sentinel
 seperate||separate
 sepperate||separate
 seperated||separated
@@ -1317,6 +1378,7 @@ secquence||sequence
 seqeunce||sequence
 sequece||sequence
 sequemce||sequence
+squence||sequence
 seqeuencer||sequencer
 seqeuncer||sequencer
 sequencial||sequential
@@ -1325,6 +1387,7 @@ servive||service
 setts||sets
 settting||setting
 serveral||several
+sharable||shareable
 hsould||should
 shoud||should
 shoule||should
@@ -1343,6 +1406,7 @@ simliar||similar
 similary||similarly
 simpified||simplified
 sleeped||slept
+slighly||slightly
 sliped||slipped
 shapshot||snapshot
 softwade||software
@@ -1376,13 +1440,16 @@ stardard||standard
 standartization||standardization
 standardss||standards
 standy||standby
+statments||statements
 staically||statically
 staticly||statically
 staion||station
 statuss||status
+stil||still
 stoped||stopped
 stoppped||stopped
 stoping||stopping
+storeing||storing
 straming||streaming
 struc||struct
 stuct||struct
@@ -1397,6 +1464,7 @@ submited||submitted
 susbsystem||subsystem
 suble||subtle
 substract||subtract
+succed||succeed
 suceed||succeed
 succeded||succeeded
 successed||succeeded
@@ -1437,6 +1505,7 @@ switchs||switches
 swithcing||switching
 swithing||switching
 symetric||symmetric
+syncronise||synchronise
 syncronize||synchronize
 synchonized||synchronized
 syncronized||synchronized
@@ -1448,6 +1517,7 @@ sythesis||synthesis
 syfs||sysfs
 syste||system
 sytem||system
+taget||target
 traget||target
 targetted||targeted
 targetting||targeting
@@ -1456,6 +1526,7 @@ temperture||temperature
 temproarily||temporarily
 temorary||temporary
 taht||that
+thats||that's
 teh||the
 thier||their
 therfore||therefore
@@ -1468,6 +1539,7 @@ threshhold||threshold
 thresold||threshold
 treshold||threshold
 throught||through
+thru||through
 troughput||throughput
 timout||timeout
 timeing||timing
@@ -1496,6 +1568,7 @@ trys||tries
 tiggered||triggered
 trigerred||triggered
 triggerd||triggered
+triggerred||triggered
 trigerring||triggering
 tiggers||triggers
 ture||true
@@ -1550,12 +1623,14 @@ untill||until
 ununsed||unused
 udpate||update
 upate||update
+udpated||updated
 usege||usage
 uesd||used
 usefule||useful
 usefull||useful
 unuseful||useless
 usera||users
+userpsace||userspace
 usualy||usually
 utilites||utilities
 utillities||utilities
-- 
2.25.1


