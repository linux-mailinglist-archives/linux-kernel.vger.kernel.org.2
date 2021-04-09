Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D635A8EC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhDIWmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 18:42:05 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:34972 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhDIWmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 18:42:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 67A5440947;
        Sat, 10 Apr 2021 00:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1618008104; x=1619822505;
         bh=sPBlp1D26nv9hcW/Hg+YUBTZ/CAoqjUj8xYrxnIpPtY=; b=ZStqwuhu3NKB
        ME2Mg+6smMHbzWANkSN1XKdyqWgO2PBkGRD80YEPgRBgz/WRl0j4UmztdsTr82Lg
        jwYpvFpTgsjJ6jdonVadbAAnZYaHRrnSqBp/xh2GmPB/ziiMzN66n/xK4PR927p4
        CsOUPhVG71YHTArAEX9S6lBQjYIR8OM12JH929BcGsHVVALVZuvJzdUNXbnzPrca
        Wr34pUDw9ceqWLpfDT9tC6dj5F1ixLXfTSgIgVUKLsPWYmku0UQlokkysMQXOAah
        OiPL4JbW1koHTYwO3Ihj+i82utt8HHy94Fu1RDFzdhJZTk7S7RzkRGjWGccgQ7xC
        9Ygkc68ERT6Mh7Vn/a7DNRq4393qJDbZg6ykJfsWxuSSgOqz6WXku4xYqC9ul+iE
        MBb67AUTzHsCGHFfESvw5NmgqyhhddwJw0WiWJ/nwKmwxWKbNE/6TTk8hU3Qkylv
        nLIp8jACGrK9uPLvH5Qlw2nhasICIlgmFv6Vu+uI2R3me9yW/oU9hQimQ44F17ie
        UplP8W1jHnz3OEQDtEnP4wViq0h0NGa30mXkvB/aAqSH43C7/vQz9SyJ0AEGC0eT
        hKAUccsANK/5xB8f4wDU99e13IiDLbdYD/Uz1g2KiqHAe8ERjOo17UzkKbW+7Oes
        6N7FUlWb7Ev1Q5qona66/3GRkYhcTts=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VNPDh62fZr-0; Sat, 10 Apr 2021 00:41:44 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id BBD50403EB;
        Sat, 10 Apr 2021 00:41:42 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id A4A6718E0;
        Sat, 10 Apr 2021 00:41:41 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: align Italian documentation
Date:   Sat, 10 Apr 2021 00:41:04 +0200
Message-Id: <20210409224104.30471-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translation for the following patches

commit 7dfbea4c468c ("scripts: remove namespace.pl")
commit 1a63f9cce7b7 ("docs: Remove make headers_check from checklist")
commit 1e013ff7cb54 ("docs: Document cross-referencing using relative path")
commit 0be1511f516e ("Documentation: doc-guide: fixes to sphinx.rst")
commit 911358401284 ("kernel-doc: Fix example in Nested structs/unions")
commit 875f82cb374b ("Documentation/submitting-patches: Extend commit message layout description")
commit 78f101a1b258 ("Documentation/submitting-patches: Add blurb about backtraces in commit messages")
commit f0ea149eee6b ("docs: submitting-patches: Emphasise the requirement to Cc: stable when using Fixes: tag")
commit 05a5f51ca566 ("Documentation: Replace lkml.org links with lore")
commit 9bf19b78a203 ("Documentation/submitting-patches: Document the SoB chain")
commit b7592e5b82db ("docs: Remove the Microsoft rhetoric")
commit 26606ce072d4 ("coding-style.rst: Avoid comma statements")
commit dd58e649742a ("docs: Make syscalls' helpers naming consistent")
commit 460cd17e9f7d ("net: switch to the kernel.org patchwork instance")
commit 163ba35ff371 ("doc: use KCFLAGS instead of EXTRA_CFLAGS to pass flags from command line")
commit 0ef597c3ac49 ("docs: remove mention of ENABLE_MUST_CHECK")
commit f8408264c77a ("drivers: Remove CONFIG_OPROFILE support")
commit 0653c358d2dc ("scsi: Drop gdth driver")
commit f8ae7bbec726 ("net: x25_asy: Delete the x25_asy driver")
commit cf6d6fc27936 ("docs: process/howto.rst: make sections on bug reporting match practice")
commit da514157c4f0 ("docs: make reporting-bugs.rst obsolete")
commit 4f8af077a02e ("docs: Fix reST markup when linking to sections")
commit 3a4928cf5e3c ("Documentation: kernel-hacking: change 'current()' to 'current'")
commit c170f2eb9648 ("docs: Document cross-referencing between documentation pages")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/doc-guide/sphinx.rst   | 47 +++++----
 .../it_IT/kernel-hacking/hacking.rst          |  2 +-
 .../it_IT/kernel-hacking/locking.rst          | 12 +--
 .../translations/it_IT/process/4.Coding.rst   |  9 +-
 .../it_IT/process/adding-syscalls.rst         |  2 +-
 .../it_IT/process/coding-style.rst            | 22 ++++-
 .../translations/it_IT/process/howto.rst      | 25 +++--
 .../it_IT/process/magic-number.rst            |  2 -
 .../it_IT/process/submit-checklist.rst        |  7 +-
 .../it_IT/process/submitting-patches.rst      | 98 +++++++++++++++----
 10 files changed, 154 insertions(+), 72 deletions(-)

diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 090d2949d345..0046d75d9a70 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -330,17 +330,17 @@ la lista di celle che compongono la *riga* stessa. Fanno eccezione i *commenti*
         - head col 3
         - head col 4
 
-      * - column 1
+      * - row 1
         - field 1.1
         - field 1.2 with autospan
 
-      * - column 2
+      * - row 2
         - field 2.1
         - :rspan:`1` :cspan:`1` field 2.2 - 3.3
 
       * .. _`it last row`:
 
-        - column 3
+        - row 3
 
 Che verrà rappresentata nel seguente modo:
 
@@ -352,37 +352,46 @@ Che verrà rappresentata nel seguente modo:
         - head col 3
         - head col 4
 
-      * - column 1
+      * - row 1
         - field 1.1
         - field 1.2 with autospan
 
-      * - column 2
+      * - row 2
         - field 2.1
         - :rspan:`1` :cspan:`1` field 2.2 - 3.3
 
       * .. _`it last row`:
 
-        - column 3
+        - row 3
 
 Riferimenti incrociati
 ----------------------
 
-Per fare dei riferimenti incrociati da una pagina ad un'altra
-specificando il percorso a partire dalla cartella *Documentation*.
-Per esempio, se volete aggiungere un riferimento a questa pagina
-(l'estensione .rst è opzionale)::
+Aggiungere un riferimento incrociato da una pagina della
+documentazione ad un'altra può essere fatto scrivendo il percorso al
+file corrispondende, non serve alcuna sintassi speciale. Si possono
+usare sia percorsi assoluti che relativi. Quelli assoluti iniziano con
+"documentation/". Per esempio, potete fare riferimento a questo
+documento in uno dei seguenti modi (da notare che l'estensione
+``.rst`` è necessaria)::
 
-    See Documentation/translations/it_IT/doc-guide/sphinx.rst.
+    Vedere Documentation/doc-guide/sphinx.rst. Questo funziona sempre
+    Guardate pshinx.rst, che si trova nella stessa cartella.
+    Leggete ../sphinx.rst, che si trova nella cartella precedente.
 
-Se preferite usare un percorso relative allora vi serve la direttiva
-Sphinx ``doc``.  Per esempio, se volete aggiungere un riferimento a
-questa pagina dalla stessa cartella::
+Se volete che il collegamento abbia un testo diverso rispetto al
+titolo del documento, allora dovrete usare la direttiva Sphinx
+``doc``. Per esempio::
 
-    See :doc:`sphinx`.
+    Vedere :doc:`il mio testo per il collegamento <sphinx>`.
 
-Per maggiori informazioni su come aggiungere riferimenti incrociati a
-commenti kernel-doc di funzioni o tipi, leggete
-Documentation/translations/it_IT/doc-guide/sphinx.rst.
+Nella maggioranza dei casi si consiglia il primo metodo perché è più
+pulito ed adatto a chi legge dai sorgenti. Se incontrare un ``:doc:``
+che non da alcun valore, sentitevi liberi di convertirlo in un
+percorso al documento.
+
+Per informazioni riguardo ai riferimenti incrociati ai commenti
+kernel-doc per funzioni o tipi, consultate
 
 .. _it_sphinx_kfigure:
 
@@ -391,7 +400,7 @@ Figure ed immagini
 
 Se volete aggiungere un'immagine, utilizzate le direttive ``kernel-figure``
 e ``kernel-image``. Per esempio, per inserire una figura di un'immagine in
-formato SVG::
+formato SVG (:ref:`it_svg_image_example`)::
 
     .. kernel-figure::  ../../../doc-guide/svg_image.svg
        :alt:    una semplice immagine SVG
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index 3d30b69f1ec1..f6beb385b4ac 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -369,7 +369,7 @@ all'inizio dell'avvio del sistema è attraverso la procedura
 Prima di inventare la vostra cache per gli oggetti più usati, considerate
 l'uso di una cache slab disponibile in ``include/linux/slab.h``.
 
-:c:func:`current()`
+:c:macro:`current`
 -------------------
 
 Definita in ``include/asm/current.h``
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index bf1acd6204ef..1e7c84def369 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -127,11 +127,11 @@ il vostro processo si auto-sospenderà; verrà riattivato quando il mutex
 verrà rilasciato. Questo significa che il processore potrà occuparsi d'altro
 mentre il vostro processo è in attesa. Esistono molti casi in cui non potete
 permettervi di sospendere un processo (vedere
-:ref:`Quali funzioni possono essere chiamate in modo sicuro dalle interruzioni? <it_sleeping-things>`)
+`Quali funzioni possono essere chiamate in modo sicuro dalle interruzioni?`_)
 e quindi dovrete utilizzare gli spinlock.
 
 Nessuno di questi *lock* è ricorsivo: vedere
-:ref:`Stallo: semplice ed avanzato <it_deadlock>`
+`Stallo: semplice ed avanzato`_
 
 I *lock* e i kernel per sistemi monoprocessore
 ----------------------------------------------
@@ -190,7 +190,7 @@ perfetto questa funzione si chiamerebbe 'spin_lock_softirq()').
 
 Da notare che in questo caso potete utilizzare anche spin_lock_irq()
 o spin_lock_irqsave(), queste fermano anche le interruzioni hardware:
-vedere :ref:`Contesto di interruzione hardware <it_hardirq-context>`.
+vedere `Contesto di interruzione hardware`_.
 
 Questo funziona alla perfezione anche sui sistemi monoprocessore: gli spinlock
 svaniscono e questa macro diventa semplicemente local_bh_disable()
@@ -241,7 +241,7 @@ Lo stesso softirq
 
 Lo stesso softirq può essere eseguito su un diverso processore: allo scopo
 di migliorare le prestazioni potete utilizzare dati riservati ad ogni
-processore (vedere :ref:`Dati per processore <it_per-cpu>`). Se siete arrivati
+processore (vedere `Dati per processore`_). Se siete arrivati
 fino a questo punto nell'uso dei softirq, probabilmente tenete alla scalabilità
 delle prestazioni abbastanza da giustificarne la complessità aggiuntiva.
 
@@ -896,8 +896,6 @@ leggendo solamente il codice. E come dice Alan Cox: “Lock data, not code”.
 Problemi comuni
 ===============
 
-.. _`it_deadlock`:
-
 Stallo: semplice ed avanzato
 ----------------------------
 
@@ -1282,7 +1280,6 @@ Il beneficio qui sta nel fatto che il contatore di riferimenti no
 viene scritto: l'oggetto non viene alterato in alcun modo e quindi diventa
 molto più veloce su sistemi molti-processore grazie alla loro memoria cache.
 
-.. _`it_per-cpu`:
 
 Dati per processore
 -------------------
@@ -1333,7 +1330,6 @@ Naturalmente, questo è più lento della semplice chiamata
 spin_lock_irq(), quindi ha senso solo se questo genere di accesso
 è estremamente raro.
 
-.. _`it_sleeping-things`:
 
 Quali funzioni possono essere chiamate in modo sicuro dalle interruzioni?
 =========================================================================
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index 8012fe9497ae..54fd255b77d0 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -264,11 +264,10 @@ La maggior parte di queste opzioni possono essere attivate per qualsiasi
 kernel utilizzato per lo sviluppo o a scopo di test.  In particolare dovreste
 attivare:
 
- - ENABLE_MUST_CHECK e FRAME_WARN per ottenere degli
-   avvertimenti dedicati a problemi come l'uso di interfacce deprecate o
-   l'ignorare un importante valore di ritorno di una funzione.  Il risultato
-   generato da questi avvertimenti può risultare verboso, ma non bisogna
-   preoccuparsi per gli avvertimenti provenienti da altre parti del kernel.
+ - FRAME_WARN per ottenere degli avvertimenti su stack frame più
+   grandi di un dato valore.  Il risultato generato da questi
+   avvertimenti può risultare verboso, ma non bisogna preoccuparsi per
+   gli avvertimenti provenienti da altre parti del kernel.
 
  - DEBUG_OBJECTS aggiungerà un codice per tracciare il ciclo di vita di
    diversi oggetti creati dal kernel e avvisa quando qualcosa viene eseguito
diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst b/Documentation/translations/it_IT/process/adding-syscalls.rst
index c478b6e8c292..df8c652d004b 100644
--- a/Documentation/translations/it_IT/process/adding-syscalls.rst
+++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
@@ -562,7 +562,7 @@ kernel.  Se la nuova funzionalità è utile all'interno del kernel, per esempio
 dev'essere condivisa fra una vecchia e una nuova chiamata di sistema o
 dev'essere utilizzata da una chiamata di sistema e la sua variante compatibile,
 allora dev'essere implementata come una funzione di supporto
-(*helper function*) (per esempio ``kern_xyzzy()``).  Questa funzione potrà
+(*helper function*) (per esempio ``ksys_xyzzy()``).  Questa funzione potrà
 essere chiamata dallo *stub* (``sys_xyzzy()``), dalla variante compatibile
 (``compat_sys_xyzzy()``), e/o da altri parti del kernel.
 
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index c86c4543f249..95f2e7c985e2 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -75,9 +75,26 @@ stessa riga:
 	if (condition) do_this;
 	  do_something_everytime;
 
-né mettete più assegnamenti sulla stessa riga.  Lo stile del kernel
+Non usate le virgole per evitare le parentesi:
+
+.. code-block:: c
+
+	if (condition)
+               do_this(), do_that();
+
+Invece, usate sempre le parentesi per racchiudere più istruzioni.
+
+.. code-block:: c
+
+	if (condition) {
+               do_this();
+               do_that();
+       }
+
+Non mettete nemmeno più assegnamenti sulla stessa riga.  Lo stile del kernel
 è ultrasemplice.  Evitate espressioni intricate.
 
+
 Al di fuori dei commenti, della documentazione ed escludendo i Kconfig, gli
 spazi non vengono mai usati per l'indentazione, e l'esempio qui sopra è
 volutamente errato.
@@ -320,8 +337,7 @@ qualcosa di simile, **non** dovreste chiamarla ``cntusr()``.
 
 Codificare il tipo di funzione nel suo nome (quella cosa chiamata notazione
 ungherese) è stupido - il compilatore conosce comunque il tipo e
-può verificarli, e inoltre confonde i programmatori.  Non c'è da
-sorprendersi che MicroSoft faccia programmi bacati.
+può verificarli, e inoltre confonde i programmatori.
 
 Le variabili LOCALI dovrebbero avere nomi corti, e significativi.  Se avete
 un qualsiasi contatore di ciclo, probabilmente sarà chiamato ``i``.
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 1db5a1082389..9554368a2ae2 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -357,17 +357,10 @@ benvenuti.
 Riportare Bug
 -------------
 
-https://bugzilla.kernel.org è dove gli sviluppatori del kernel Linux tracciano
-i bachi del kernel. Gli utenti sono incoraggiati nel riportare tutti i bachi
-che trovano utilizzando questo strumento.
-Per maggiori dettagli su come usare il bugzilla del kernel, guardare:
-
-	https://bugzilla.kernel.org/page.cgi?id=faq.html
-
-Il file admin-guide/reporting-bugs.rst nella cartella principale del kernel
-fornisce un buon modello sul come segnalare un baco nel kernel, e spiega quali
-informazioni sono necessarie agli sviluppatori per poter aiutare il
-rintracciamento del problema.
+Il file 'Documentation/admin-guide/reporting-issues.rst' nella
+cartella principale del kernel spiega come segnalare un baco nel
+kernel, e fornisce dettagli su quali informazioni sono necessarie agli
+sviluppatori del kernel per poter studiare il problema.
 
 Gestire i rapporti sui bug
 --------------------------
@@ -380,8 +373,14 @@ al corrente della vostra presenza. Riparare bachi è una delle migliori vie per
 acquisire meriti tra gli altri sviluppatori, perchè non a molte persone piace
 perdere tempo a sistemare i bachi di altri.
 
-Per lavorare sui rapporti di bachi già riportati, andate su
-https://bugzilla.kernel.org.
+Per lavorare sui bachi già segnalati, per prima cosa cercate il
+sottosistema che vi interessa. Poi, verificate nel file MAINTAINERS
+dove vengono collezionati solitamente i bachi per quel sottosistema;
+spesso sarà una lista di discussione, raramente un bugtracker. Cercate
+bachi nell'archivio e aiutate dove credete di poterlo fare. Potete
+anche consultare https://bugzilla.kernel.org; però, solo una manciata di
+sottosistemi lo usano attivamente, ciò nonostante i bachi che
+coinvolgono l'intero kernel sono sempre riportati lì.
 
 Liste di discussione
 --------------------
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index 1af30f4228f2..26bc08e65872 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -105,7 +105,6 @@ USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/usb/se
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/linux/ufs_fs.h``
 RPORT_MAGIC           0x00525001       r_port                   ``drivers/char/rocket_int.h``
 LSEMAGIC              0x05091998       lse                      ``drivers/fc4/fc.c``
-GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/linux/nbd.h``
 RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.c``
@@ -148,7 +147,6 @@ PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/usb/me
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
-DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drivers/scsi/gdth.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/net/hamradio/yam.c``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/scsi/arm/queue.c``
diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index 62ba471921b6..2fc09cc1f0be 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -28,6 +28,10 @@ sottomissione delle patch, in particolare
 
   c) quando si usa ``O=builddir``
 
+  d) Qualsiasi modifica in Documentation/ deve compilare con successo senza
+     avvisi o errori. Usare ``make htmldocs`` o ``make pdfdocs`` per verificare
+     e correggere i problemi
+
 3) Compilare per diverse architetture di processore usando strumenti per
    la cross-compilazione o altri.
 
@@ -54,8 +58,7 @@ sottomissione delle patch, in particolare
 
 9) Verificare con sparse.
 
-10) Usare ``make checkstack`` e ``make namespacecheck`` e correggere tutti i
-    problemi rilevati.
+10) Usare ``make checkstack`` e correggere tutti i problemi rilevati.
 
     .. note::
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index ae00352346ed..ded95048b9a8 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -433,6 +433,14 @@ Alcune persone aggiungono delle etichette alla fine.  Per ora queste verranno
 ignorate, ma potete farlo per meglio identificare procedure aziendali interne o
 per aggiungere dettagli circa la firma.
 
+In seguito al SoB (Signed-off-by:) dell'autore ve ne sono altri da
+parte di tutte quelle persone che si sono occupate della gestione e
+del trasporto della patch. Queste però non sono state coinvolte nello
+sviluppo, ma la loro sequenza d'apparizione ci racconta il percorso
+**reale** che una patch a intrapreso dallo sviluppatore, fino al
+manutentore, per poi giungere a Linus.
+
+
 Quando utilizzare Acked-by:, Cc:, e Co-developed-by:
 ----------------------------------------------------
 
@@ -574,6 +582,10 @@ kernel stabili al fine di capire quale kernel deve ricevere la correzione.
 Questo è il modo suggerito per indicare che un baco è stato corretto nella
 patch. Per maggiori dettagli leggete :ref:`it_describe_changes`
 
+Da notare che aggiungere un tag "Fixes:" non esime dalle regole
+previste per i kernel stabili, e nemmeno dalla necessità di aggiungere
+in copia conoscenza stable@vger.kernel.org su tutte le patch per
+suddetti kernel.
 
 Il formato canonico delle patch
 -------------------------------
@@ -642,16 +654,20 @@ Le etichette non verranno considerate come parte della frase riassuntiva, ma
 indicano come la patch dovrebbe essere trattata.  Fra le etichette più comuni
 ci sono quelle di versione che vengono usate quando una patch è stata inviata
 più volte (per esempio, "v1, v2, v3"); oppure "RFC" per indicare che si
-attendono dei commenti (*Request For Comments*).  Se ci sono quattro patch
-nella serie, queste dovrebbero essere enumerate così: 1/4, 2/4, 3/4, 4/4.
-Questo assicura che gli sviluppatori capiranno l'ordine in cui le patch
-dovrebbero essere applicate, e per tracciare quelle che hanno revisionate o
-che hanno applicato.
+attendono dei commenti (*Request For Comments*).
+
+Se ci sono quattro patch nella serie, queste dovrebbero essere
+enumerate così: 1/4, 2/4, 3/4, 4/4.  Questo assicura che gli
+sviluppatori capiranno l'ordine in cui le patch dovrebbero essere
+applicate, e per tracciare quelle che hanno revisionate o che hanno
+applicato.
 
 Un paio di esempi di oggetti::
 
     Subject: [PATCH 2/5] ext2: improve scalability of bitmap searching
     Subject: [PATCH v2 01/27] x86: fix eflags tracking
+    Subject: [PATCH v2] sub/sys: Condensed patch summary
+    Subject: [PATCH v2 M/N] sub/sys: Condensed patch summary
 
 La riga ``from`` dev'essere la prima nel corpo del messaggio ed è nel
 formato:
@@ -668,30 +684,76 @@ deve aver senso per un lettore esperto che è ha dimenticato i dettagli della
 discussione che hanno portato alla patch.  L'inclusione di informazioni
 sui problemi oggetto dalla patch (messaggi del kernel, messaggi di oops,
 eccetera) è particolarmente utile per le persone che potrebbero cercare fra
-i messaggi di log per la patch che li tratta.  Se la patch corregge un errore
-di compilazione, non sarà necessario includere proprio _tutto_ quello che
-è uscito dal compilatore; aggiungete solo quello che è necessario per far si
-che la vostra patch venga trovata.  Come nella ``summary phrase``, è importante
-essere sia brevi che descrittivi.
+i messaggi di log per la patch che li tratta. Il testo dovrebbe essere scritto
+con abbastanza dettagli da far capire al lettore **perché** quella
+patch fu creata, e questo a distanza di settimane, mesi, o addirittura
+anni.
+
+Se la patch corregge un errore di compilazione, non sarà necessario
+includere proprio _tutto_ quello che è uscito dal compilatore;
+aggiungete solo quello che è necessario per far si che la vostra patch
+venga trovata.  Come nella ``summary phrase``, è importante essere sia
+brevi che descrittivi.
 
 La linea di demarcazione ``---`` serve essenzialmente a segnare dove finisce
 il messaggio di changelog.
 
 Aggiungere il ``diffstat`` dopo ``---`` è un buon uso di questo spazio, per
 mostrare i file che sono cambiati, e il numero di file aggiunto o rimossi.
-Un ``diffstat`` è particolarmente utile per le patch grandi.  Altri commenti
-che sono importanti solo per i manutentori, quindi inadatti al changelog
-permanente, dovrebbero essere messi qui.  Un buon esempio per questo tipo
-di commenti potrebbe essere quello di descrivere le differenze fra le versioni
+Un ``diffstat`` è particolarmente utile per le patch grandi. Se
+includete un ``diffstat`` dopo ``---``, usate le opzioni ``-p 1 -w70``
+cosicché i nomi dei file elencati non occupino troppo spazio
+(facilmente rientreranno negli 80 caratteri, magari con qualche
+indentazione).  (``git`` genera di base dei diffstat adatti).
+
+I commenti che sono importanti solo per i manutentori, quindi
+inadatti al changelog permanente, dovrebbero essere messi qui.  Un
+buon esempio per questo tipo di commenti potrebbe essere il cosiddetto
+``patch changelogs`` che descrivere le differenze fra le versioni
 della patch.
 
-Se includete un ``diffstat`` dopo ``---``, usate le opzioni ``-p 1 -w70``
-cosicché i nomi dei file elencati non occupino troppo spazio (facilmente
-rientreranno negli 80 caratteri, magari con qualche indentazione).
-(``git`` genera di base dei diffstat adatti).
+Queste informazioni devono andare **dopo** la linea ``---`` che separa
+il *changelog* dal resto della patch. Le informazioni riguardanti la
+versione di una patch non sono parte del *chagelog* che viene incluso
+in git. Queste sono informazioni utili solo ai revisori. Se venissero
+messe sopra la riga, qualcuno dovrà fare del lavoro manuale per
+rimuoverle; cosa che invece viene fatta automaticamente quando vengono
+messe correttamente oltre la riga.::
+
+  <commit message>
+  ...
+  Signed-off-by: Author <author@mail>
+  ---
+  V2 -> V3: Removed redundant helper function
+  V1 -> V2: Cleaned up coding style and addressed review comments
+
+  path/to/file | 5+++--
+  ...
 
 Maggiori dettagli sul formato delle patch nei riferimenti qui di seguito.
 
+Aggiungere i *backtrace* nei messaggi di commit
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+I *backtrace* aiutano a documentare la sequenza di chiamate a funzione
+che portano ad un problema. Tuttavia, non tutti i *backtrace* sono
+davvero utili. Per esempio, le sequenze iniziali di avvio sono uniche
+e ovvie. Copiare integralmente l'output di ``dmesg`` aggiunge tante
+informazioni che distraggono dal vero problema (per esempio, i
+marcatori temporali, la lista dei moduli, la lista dei registri, lo
+stato dello stack).
+
+Quindi, per rendere utile un *backtrace* dovreste eliminare le
+informazioni inutili, cosicché ci si possa focalizzare sul
+problema. Ecco un esempio di un *backtrace* essenziale::
+
+  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000000000000064)
+  at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
+  Call Trace:
+  mba_wrmsr
+  update_domains
+  rdtgroup_mkdir
+
 .. _it_explicit_in_reply_to:
 
 Usare esplicitamente In-Reply-To nell'intestazione
-- 
2.20.1

